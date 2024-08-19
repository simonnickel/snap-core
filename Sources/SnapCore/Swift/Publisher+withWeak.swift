//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Combine

public extension Publisher {
	
	/// Prepare an unretained reference to an object and check for availability.
	///
	/// Example:
	///
	/// ```
	/// NotificationCenter.default
	/// 	.publisher(for: ...)
	/// 	.withWeak(self)
	/// 	.sink(receiveValue: { weakSelf, output in
	/// 		weakSelf.
	/// 	})
	///	```
	///
	/// Use as alternative to:
	///	```
	///	NotificationCenter.default
	///		.publisher(for: ...)
	///		.sink(receiveValue: { [weak self] output in
	///			self?.
	///		})
	///	```
	/// - Parameter object: The object to weakly reference.
	/// - Returns: Publisher with weak reference to object.
	func withWeak<T: AnyObject>(_ object: T) -> Publishers.CompactMap<Self, (T, Self.Output)> {
		compactMap { [weak object] output in
			guard let object = object else {
				return nil
			}
			return (object, output)
		}
	}
	
}
