//
//  View+FrameFill.swift
//  
//
//  Created by Simon Nickel on 06.09.23.
//

import SwiftUI


// MARK: - View Modifier

public extension View {
	
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
