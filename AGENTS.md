@../snap/agents/AGENTS.md

# SnapCore

A package of independent Swift/SwiftUI utilities: extensions, retroactive `Codable` conformances for SwiftUI types, and convenience types.

## Bug workarounds

Several SwiftUI views and modifiers exist solely to patch framework bugs — FB numbers are in source comments. Don't simplify them: `PickerTapable`, `ToggleTapable`, `ReloadOnAppearModifier`, `EmptyNoSpaceView`.
