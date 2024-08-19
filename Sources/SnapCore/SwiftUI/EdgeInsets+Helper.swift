//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public extension EdgeInsets {
	
	/// Convenience init to set top, leading, bottom and trailing to same value.
	/// - Parameter value: The value to apply.
	init(all value: CGFloat) {
		self.init(top: value, leading: value, bottom: value, trailing: value)
	}
	
	/// Convenience init to set horizontal and vertical values.
	/// - Parameters:
	///   - horizontal: The value to apply to leading and trailing.
	///   - vertical: The value to apply to top and bottom.
	init(horizontal: CGFloat, vertical: CGFloat) {
		self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
	}
	
	static var zero: EdgeInsets { .init(all: 0) }
	
}
