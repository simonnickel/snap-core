//
//  Set+Helper.swift
//
//
//  Created by Simon Nickel on 14.10.23.
//

import Foundation

public extension Set where Element: Hashable {
	
	/// Copy of the Collection appended by elements if they are not part of the Array already. Does not remove duplicates already part of the Array.
	/// - Parameter contentsOf: Elements to append.
	/// - Returns: Copy appended by elements.
	func inserted<S>(_ element: S) -> Self where Element == S.Element, S : Sequence {
		var copy = self
		for elem in element {
			copy.insert(elem)
		}
		return copy
	}
	
	/// Copy of the Array appended by element if not part of the Array already. Does not remove duplicates already part of the Array.
	/// - Parameter element: Element to append.
	/// - Returns: Copy appended by element.
	func inserted(_ element: Element) -> Self {
		var copy = self
		copy.insert(element)
		return copy
	}
	
}
