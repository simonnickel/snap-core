//
//  Collection+Safe.swift
//  SnapCore
//
//  Created by Simon Nickel on 07.12.22.
//

import Foundation

public extension Collection {
	
	/// Returns the element at the specified index if it is within bounds, otherwise nil.
	subscript (checking index: Index) -> Element? {
		return indices.contains(index) ? self[index] : nil
	}
	
}
