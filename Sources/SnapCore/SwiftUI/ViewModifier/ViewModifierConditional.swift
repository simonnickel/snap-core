//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

// Combining both variants with an optional else transform (if: transform, else: transform? = nil) seems not to work.
// Separate generic return types are necessary, and the optional type can not be inferred if nil.
// Other implementations run into: Type 'any View' cannot conform to 'View'


// MARK: .if:

public extension View {
	
	///	Be careful, this does not maintain view identify (see: https://www.objc.io/blog/2021/08/24/conditional-view-modifiers/ ).
	///
	/// Applies the transform if the condition evaluates to `true`.
	/// - Parameters:
	///   - condition: The condition to evaluate.
	///   - transform: The transform to apply to the source `View`.
	/// - Returns: Either the original `View` or the modified `View`, if the condition is `true`.
	///
	/// ```
	/// var stateNotChanging: Bool
	///	Text("Hello, world!")
	///		.if(stateNotChanging) { view in
	/// 		view.background(Color.red)
	///	   	}
	///```
	@ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
		if condition() {
			transform(self)
		} else {
			self
		}
	}

}


// MARK: .if:, else:

public extension View {
	
	///	Be careful, this does not maintain view identify (see: https://www.objc.io/blog/2021/08/24/conditional-view-modifiers/ ).
	///
	/// Applies the transform if the condition evaluates to `true`, applies the else transform otherwise.
	/// - Parameters:
	///   - condition: The condition to evaluate.
	///   - transform: The transform to apply to the source `View`, if the condition is met.
	///   - else: Optional transform to apply to the source `View`, if the condition is NOT met.
	/// - Returns: The modified `View`.
	///
	/// ```
	/// var stateNotChanging: Bool
	///	Text("Hello, world!")
	///		.if(stateNotChanging) { view in
	/// 		view.background(Color.red)
	///	   	} else: {
	///			view.background(Color.clear)
	///	   	}
	///```
	@ViewBuilder func `if`<ContentIf: View, ContentElse: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> ContentIf, `else` transformOther: (Self) -> ContentElse) -> some View {
		if condition() {
			transform(self)
		} else {
			transformOther(self)
		}
	}

}


// MARK: .if: unwrap

public extension View {
	
	///	Be careful, this does not maintain view identify (see: https://www.objc.io/blog/2021/08/24/conditional-view-modifiers/ ).
	///
	/// Unwraps the optional and applies the transform using the unwrapped value.
	/// - Parameters:
	///   - unwrap: The optional to unwrap.
	///   - transform: The transform to apply to the source `View`.
	/// - Returns: Either the modified `View` or the original `View`.
	///
	/// ```
	/// var color: Color?
	///	Text("Hello, world!")
	///		.if(unwrap: color) { view, color in
	/// 		view.background(color)
	///		}
	/// ```
	@ViewBuilder func `if`<Content: View, OptionalType: Any>(unwrap: OptionalType?, transform: (Self, OptionalType) -> Content) -> some View {
		if let unwrapped = unwrap {
			transform(self, unwrapped)
		} else {
			self
		}
	}
	
}


// MARK: .if: unwrap, else:

public extension View {
	
	///	Be careful, this does not maintain view identify (see: https://www.objc.io/blog/2021/08/24/conditional-view-modifiers/ ).
	///
	/// Unwraps the optional and applies the transform using the unwrapped value, applies the else transform if the optional has no value.
	/// - Parameters:
	///   - unwrap: The optional to unwrap.
	///   - transform: The transform to apply to the source `View`, if the optinal has a value.
	///   - else: Optional transform to apply to the source `View`, if the optional does NOT have a value.
	/// - Returns: The modified `View`.
	///
	/// ```
	/// var color: Color?
	///	Text("Hello, world!")
	///		.if(unwrap: color) { view, color in
	/// 		view.background(color)
	///		} else: {
	///			view.background(Color.clear)
	///		}
	/// ```
	@ViewBuilder func `if`<ContentIf: View, ContentElse: View, OptionalType: Any>(unwrap: OptionalType?, transform: (Self, OptionalType) -> ContentIf, `else` transformOther: (Self) -> ContentElse) -> some View {
		if let unwrapped = unwrap {
			transform(self, unwrapped)
		} else {
			transformOther(self)
		}
	}
	
}
