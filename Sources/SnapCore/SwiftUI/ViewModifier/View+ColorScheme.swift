//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public extension View {
    // `.colorScheme()` with inert value `nil` to keep value from Environment.
    func colorScheme(_ colorScheme: ColorScheme?) -> some View {
        self
            .modifier(ColorSchemeModifier(value: colorScheme))
    }
}

struct ColorSchemeModifier: ViewModifier {
    
    @Environment(\.colorScheme) var fromEnvironment
    
    let value: ColorScheme?
    
    func body(content: Content) -> some View {
        content
            .colorScheme(value ?? fromEnvironment)
    }

}


// MARK: - Preview

#Preview {
    let colorScheme: ColorScheme? = nil
    Text("Test")
        .padding()
        .background()
        .colorScheme(colorScheme)
}

