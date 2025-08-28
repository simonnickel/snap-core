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
        AnyView(base.makeBody(configuration: configuration))
	}
	
}
