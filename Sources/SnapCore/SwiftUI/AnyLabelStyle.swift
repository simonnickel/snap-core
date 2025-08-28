//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct AnyLabelStyle: LabelStyle {
    
    private let base: any LabelStyle
	
	public init(_ base: some LabelStyle) {
        self.base = base
	}
	
	public func makeBody(configuration: Configuration) -> some View {
        // TODO: Fix warning: Accessing Environment<Optional<CGFloat>>'s value outside of being installed on a View. This will always read the default value and will not update.
        AnyView(base.makeBody(configuration: configuration))
	}
	
}
