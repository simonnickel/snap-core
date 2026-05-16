@../snap/agents/AGENTS.md

# SnapCore

A grab-bag of Swift/SwiftUI utilities, retroactive `Codable` conformances for SwiftUI types, and convenience extensions.

## Bug workarounds

Several SwiftUI views and modifiers exist solely to patch framework bugs — FB numbers are in source comments. Don't simplify them: `PickerTapable`, `ToggleTapable`, `ReloadOnAppearModifier`, `EmptyNoSpaceView`.
