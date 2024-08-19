//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

#if canImport(UIKit)
import UIKit
public typealias ColorType = UIColor
#elseif canImport(AppKit)
import AppKit
public typealias ColorType = NSColor
#endif

public extension Color {
	
	func getPlatformSpecific(in environment: EnvironmentValues) -> ColorType {
		
		let colorResolved = resolve(in: environment)
		
		return ColorType(red: CGFloat(colorResolved.red), green: CGFloat(colorResolved.green), blue: CGFloat(colorResolved.blue), alpha: colorResolved.cgColor.alpha)
		
	}
	
}
