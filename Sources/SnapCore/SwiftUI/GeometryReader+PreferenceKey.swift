//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

/// PreferenceKey to read the size of a Geometry Reader.
///
/// ```
///	GeometryReader { reader in
///		Text("some text")
///			.preference(key: GeometryViewSizeKey.self, value: reader.size)
///	}
///	.onPreferenceChange(GeometryViewSizeKey.self) { size in
///		// Do something with the size.
///	}
/// ```
public struct GeometryViewSizeKey: PreferenceKey {
	
	public static let defaultValue: CGSize = .zero
	
	public static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
		value = nextValue()
	}
	
}
