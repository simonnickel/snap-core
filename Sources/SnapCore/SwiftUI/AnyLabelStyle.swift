//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public struct AnyLabelStyle: LabelStyle {
	
	private let bodyBuilder: (Configuration) -> AnyView
	
	public init(_ base: some LabelStyle) {
		self.bodyBuilder = { AnyView(base.makeBody(configuration: $0)) }
	}
	
	public func makeBody(configuration: Configuration) -> some View {
		bodyBuilder(configuration)
	}
	
}
