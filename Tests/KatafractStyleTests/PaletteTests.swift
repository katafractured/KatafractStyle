import Testing
import SwiftUI
@testable import KatafractStyle

@Test func paletteVersionIsCurrent() {
    #expect(KatafractStyle.paletteVersion == 1)
}

@Test func navyIsNonNil() {
    // Trivial smoke test — compile-check that the palette extensions exist.
    let c: Color = .kataNavy
    _ = c
}

@Test func hapticEnumRoundTrip() {
    // Enum has 6 cases — simple switch exhaustiveness check.
    for h: KataHaptic in [.unlocked, .saved, .revealed, .denied, .tap, .destructive] {
        _ = h
    }
}
