//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

/// Wraps `ColorScheme` to be `Codable` and `CustomStringConvertible`.
public enum SystemColorScheme: Codable, Hashable, Equatable, Sendable, CaseIterable, CustomStringConvertible {
	
	case dark, light
	
	public var system: ColorScheme {
		return switch self {
			case .dark: .dark
			case .light: .light
		}
	}
	
	public var description: String {
		return switch self {
			case .dark: ".dark"
			case .light: ".light"
		}
	}
	
}
