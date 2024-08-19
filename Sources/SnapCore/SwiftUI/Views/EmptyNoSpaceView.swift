//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

/// An `EmptyView` with size (0, 0), that can have padding.
/// For some reason `EmptyView` has a size that can not be set by `.frame`, e.g. when placed in a `DisclosureGroup`.
public struct EmptyNoSpaceView: View {
	
	public init() { }
	
	public var body: some View {
		
		ZStack {
			EmptyView()
		}
		.frame(width: 0, height: 0)
		.opacity(0)
		.disabled(true)
		
	}
	
}


// MARK: - Previews

#Preview {
	
	struct DisclosureWrapper: View {
		
		@State private var isExpanded = false
		
		let title: String
		@ViewBuilder let content: () -> any View
		
		var body: some View {
			DisclosureGroup(title, isExpanded: $isExpanded) {
				AnyView(content())
			}
		}
		
	}
	
	return VStack {
		Text("Start")
		
		DisclosureWrapper(title: "Expands no space") {
			EmptyNoSpaceView()
		}
		
		DisclosureWrapper(title: "Expands space") {
			// Does not react to .frame and .padding
			EmptyView()
				.frame(width: 0, height: 0)
			//						.padding(100)
		}
		
		DisclosureWrapper(title: "Expands space") {
			// Does not react to .frame, but to .padding
			Spacer(minLength: 0)
				.frame(width: 0, height: 0)
			//						.padding(100)
		}
		
		
		Text("End")
	}
	.scenePadding()
	
}
