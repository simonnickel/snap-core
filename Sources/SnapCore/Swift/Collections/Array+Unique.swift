//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation

public extension Array where Element: Hashable {
	
	/// Removing duplicate values while preserving the order.
	/// In most cases it is easier to use Set(array), but it does not maintain the order.
	func uniqued() -> Self {
		var buffer = Array()
		var added = Set<Element>()
		for elem in self {
			if !added.contains(elem) {
				buffer.append(elem)
				added.insert(elem)
			}
		}
		return buffer
	}
	
	/// Appends elements if they are not part of the Array already. Does not remove duplicates already part of the Array.
	/// - Parameter contentsOf: Elements to append.
	mutating func appendUnique<S>(_ element: S) where Element == S.Element, S : Sequence {
		for elem in element {
			self.appendUnique(elem)
		}
	}
	
	/// Appends element if not part of the Array already. Does not remove duplicates already part of the Array.
	/// - Parameter element: Element to append.
	mutating func appendUnique(_ element: Element) {
		if !self.contains(element) {
			self.append(element)
		}
	}
	
	/// Copy of the Array appended by elements if they are not part of the Array already. Does not remove duplicates already part of the Array.
	/// - Parameter contentsOf: Elements to append.
	/// - Returns: Copy appended by elements.
	func appendedUnique<S>(_ element: S) -> Self where Element == S.Element, S : Sequence {
		var copy = self
		copy.appendUnique(element)
		return copy
	}
	
	/// Copy of the Array appended by element if not part of the Array already. Does not remove duplicates already part of the Array.
	/// - Parameter element: Element to append.
	/// - Returns: Copy appended by element.
	func appendedUnique(_ element: Element) -> Self {
		var copy = self
		copy.appendUnique(element)
		return copy
	}
	
}
