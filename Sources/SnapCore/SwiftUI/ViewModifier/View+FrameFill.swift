//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI


// MARK: - View Modifier

public extension View {
	
	/// Convenience modifier to set the frame to `.infinity` for `maxWidth` and `maxHeight`.
	/// - Parameter alignment: The alignment applied to `.frame()`.
	/// - Returns: The modified View.
	func frameFill(alignment: Alignment = .center) -> some View {
		return self.modifier(FrameFill(alignment: alignment))
	}
	
}

private struct FrameFill: ViewModifier {
	
	let alignment: Alignment
	
	public func body(content: Content) -> some View {
		return content
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
	}
	
}


// MARK: - Previews

#Preview {
	
	VStack {
		Text("Test")
			.padding()
			.background(.red)
	}
	.frameFill(alignment: .top)
	.background(.green)
	.scenePadding()
	
}
