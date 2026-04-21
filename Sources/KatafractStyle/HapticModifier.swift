import SwiftUI

/// SwiftUI adoption sugar for `KataHaptic`. Use these modifiers to wire semantic
/// haptics into Buttons, toggles, gestures, and value-change observers without
/// writing imperative `KataHaptic.X.fire()` calls at every call site.

public extension View {

    /// Fire a `KataHaptic` when the user taps this view, then run the given action.
    ///
    /// Use on any tappable SwiftUI view that isn't already a `Button`. For `Button`s,
    /// prefer `.kataHaptic(_:)` which wraps the button's action.
    ///
    ///     Image(systemName: "xmark.circle")
    ///         .onTapHaptic(.destructive) { delete() }
    ///
    func onTapHaptic(_ kind: KataHaptic, perform action: @escaping () -> Void) -> some View {
        self.onTapGesture {
            Task { @MainActor in kind.fire() }
            action()
        }
    }

    /// Fire a `KataHaptic` whenever the provided Equatable value changes.
    ///
    /// Use for toggles, pickers, sliders, or any @State value whose every mutation
    /// deserves a tactile confirmation.
    ///
    ///     Toggle("Block trackers", isOn: $blockOn)
    ///         .hapticOnChange(of: blockOn, .tap)
    ///
    func hapticOnChange<V: Equatable>(of value: V, _ kind: KataHaptic) -> some View {
        self.onChange(of: value) { _, _ in
            Task { @MainActor in kind.fire() }
        }
    }

    /// Fire a `KataHaptic` when the view appears. Use sparingly — primarily for
    /// modal reveal confirmation (`.revealed`) when the view is a sheet / fullscreen
    /// cover that benefits from a tactile "here you are."
    ///
    ///     PaywallView()
    ///         .hapticOnAppear(.revealed)
    ///
    func hapticOnAppear(_ kind: KataHaptic) -> some View {
        self.onAppear {
            Task { @MainActor in kind.fire() }
        }
    }
}

public extension Button {
    /// Wraps a Button so that tapping fires the given haptic before the action runs.
    ///
    ///     Button("Save") { save() }
    ///         .kataHaptic(.saved)
    ///
    /// The haptic fires on the main actor; the action runs synchronously afterwards
    /// on whatever actor the caller provides.
    ///
    /// Note: this is a ViewModifier, so it composes with other modifiers cleanly.
    /// It does not alter the button's label — only adds haptic behavior.
    func kataHaptic(_ kind: KataHaptic) -> some View {
        self.simultaneousGesture(
            TapGesture().onEnded {
                Task { @MainActor in kind.fire() }
            }
        )
    }
}

/// A button that fires a `KataHaptic` before executing its action. Prefer this when
/// you're constructing a new button and want haptics baked in without reaching for
/// the `.kataHaptic()` modifier.
///
///     HapticButton("Delete", haptic: .destructive) {
///         delete()
///     }
///
public struct HapticButton<Label: View>: View {
    private let haptic: KataHaptic
    private let role: ButtonRole?
    private let action: () -> Void
    private let label: () -> Label

    public init(
        haptic: KataHaptic,
        role: ButtonRole? = nil,
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.haptic = haptic
        self.role = role
        self.action = action
        self.label = label
    }

    public var body: some View {
        Button(role: role) {
            Task { @MainActor in haptic.fire() }
            action()
        } label: {
            label()
        }
    }
}

public extension HapticButton where Label == Text {
    /// Convenience for the common `HapticButton("Title", haptic:) { … }` shape.
    init(
        _ title: String,
        haptic: KataHaptic,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.init(haptic: haptic, role: role, action: action) {
            Text(title)
        }
    }
}
