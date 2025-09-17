//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public extension EnvironmentValues {
    @Entry var enabled: Bool = true
}

extension View {
    /// Sets the view disabled if set to false, but also provides the value via Environment.
    public func enabled(_ enabled: Bool) -> some View {
        self
            .environment(\.enabled, enabled)
            .disabled(!enabled)
    }
}


// MARK: - Preview

#Preview {
    Button {
        
    } label: {
        Text("Button")
    }
    .padding()
    .enabled(false)
}
