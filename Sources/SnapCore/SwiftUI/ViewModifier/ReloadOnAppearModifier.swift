//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

/// Invalidates the view onAppear to trigger a rerender, used to work around SwiftUI bugs.
public struct ReloadOnAppearModifier: ViewModifier {
    
    @State private var didAppear: Bool = false
    
    public init() {}

    public func body(content: Content) -> some View {
        content
            .id(didAppear)
            .onAppear {
                didAppear = true
            }
    }
    
}
