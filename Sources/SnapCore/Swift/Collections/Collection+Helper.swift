//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation

public extension Collection {
	
	/// Returns the element at the specified index if it is within bounds, otherwise nil.
	subscript (checking index: Index) -> Element? {
		return indices.contains(index) ? self[index] : nil
	}
	
}
