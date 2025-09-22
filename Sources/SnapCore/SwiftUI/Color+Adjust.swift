//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public extension Color {
	
	struct HSBA: Codable, Hashable, Equatable, Sendable, CustomStringConvertible {
		
		public init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
			self.hue = hue
			self.saturation = saturation
			self.brightness = brightness
			self.alpha = alpha
		}
		
		var hue: CGFloat
		var saturation: CGFloat
		var brightness: CGFloat
		var alpha: CGFloat
		
		public var color: Color {
			Color(hue: hue, saturation: saturation, brightness: brightness, opacity: alpha)
		}
		
		public var description: String {
			"h: \(hue), s: \(saturation), b: \(brightness), alpha: \(alpha)"
		}
		
	}
	
	struct Adjustment: Codable, Hashable, Equatable, Sendable {
		public init(hue: Color.ValueAdjustment? = nil, saturation: Color.ValueAdjustment? = nil, brightness: Color.ValueAdjustment? = nil, alpha: Color.ValueAdjustment? = nil) {
			self.hue = hue
			self.saturation = saturation
			self.brightness = brightness
			self.alpha = alpha
		}
		
		let hue: ValueAdjustment?
		let saturation: ValueAdjustment?
		let brightness: ValueAdjustment?
		let alpha: ValueAdjustment?
	}
	
	enum ValueAdjustment: Codable, Hashable, Equatable, Sendable, CustomStringConvertible {
		case add(CGFloat), multiply(CGFloat), replace(CGFloat)
		
		func adjusted(value: CGFloat) -> CGFloat {
			return switch self {
				case .add(let adjustment): value + adjustment
				case .multiply(let adjustment): value * adjustment
				case .replace(let adjustment): adjustment
			}
		}
		
		public var description: String {
			return switch self {
				case .add(let value): "+\(value)"
				case .multiply(let value): "*\(value)"
				case .replace(let value): "\(value)"
			}
		}
	}
	
	init(_ hsba: HSBA) {
		self.init(hue: hsba.hue, saturation: hsba.saturation, brightness: hsba.brightness, opacity: hsba.alpha)
	}
	
	func getHSBA(in environment: EnvironmentValues) -> HSBA {
		var hue: CGFloat = 0
		var saturation: CGFloat = 0
		var brightness: CGFloat = 0
		var alpha: CGFloat = 1
		
		let colorPlatform = getPlatformSpecific(in: environment)
		colorPlatform.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
		
		return HSBA(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
	}
	
	func adjusted(_ adjustment: Color.Adjustment?, in environment: EnvironmentValues) -> Color {
		return adjusted(hue: adjustment?.hue, saturation: adjustment?.saturation, brightness: adjustment?.brightness, alpha: adjustment?.alpha, in: environment)
	}
	
	func adjusted(hue: ValueAdjustment? = nil, saturation: ValueAdjustment? = nil, brightness: ValueAdjustment? = nil, alpha: ValueAdjustment? = nil, in environment: EnvironmentValues) -> Color {
		var hsba = getHSBA(in: environment)
		if let hue {
			hsba.hue = hue.adjusted(value: hsba.hue)
		}
		if let saturation {
			hsba.saturation = saturation.adjusted(value: hsba.saturation)
		}
		if let brightness {
			hsba.brightness = brightness.adjusted(value: hsba.brightness)
		}
		if let alpha {
			hsba.alpha = alpha.adjusted(value: hsba.alpha)
		}
		return Color(hsba)
	}
	
}


extension Color.Adjustment: CustomStringConvertible {
	
	public var description: String {
		return "h: \(hue?.description ?? "-"), s: \(saturation?.description ?? "-"), b: \(brightness?.description ?? "-"), a: \(alpha?.description ?? "-")"
	}
	
}
