//
//  WeakRef.swift
//  SnapCore
//
//  Created by Simon Nickel on 06.10.23.
//

import Foundation

/// Wrapper to hold a weak reference to an object,  e.g. store weak references in a `Collection`.
public final class WeakRef<T> where T: AnyObject {
	
	public init(value: T?) {
		self.value = value
	}
	
	public weak var value: T?
	
	public var isEmpty: Bool { value == nil }
	
}
