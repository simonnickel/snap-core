//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
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
