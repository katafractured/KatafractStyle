import Testing
import SwiftUI
@testable import KatafractStyle

/// Compile-level smoke tests for the haptic modifier API. We can't assert that a
/// haptic actually fired on a test device, but we can confirm the surface compiles
/// and composes with real SwiftUI views.

@MainActor
@Test func onTapHapticCompiles() {
    let _ = Text("tap me")
        .onTapHaptic(.tap) { }
}

@MainActor
@Test func hapticOnChangeCompiles() {
    let _ = Text("status")
        .hapticOnChange(of: 0, .saved)
}

@MainActor
@Test func hapticOnAppearCompiles() {
    let _ = Text("modal")
        .hapticOnAppear(.revealed)
}

@MainActor
@Test func kataHapticModifierOnButtonCompiles() {
    let _ = Button("Save") { }
        .kataHaptic(.saved)
}

@MainActor
@Test func hapticButtonTitleInitCompiles() {
    let _ = HapticButton("Delete", haptic: .destructive, role: .destructive) { }
}

@MainActor
@Test func hapticButtonViewBuilderInitCompiles() {
    let _ = HapticButton(haptic: .unlocked) {
        // action
    } label: {
        Image(systemName: "lock.open")
    }
}
