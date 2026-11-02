//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

/// Extends `Angle` to be `Codable`.
extension Angle: @retroactive Codable {
	
	// `degrees` is not stored, because `radians` already defines the angle and converting back from `degrees` can change the value through floating point rounding, such as `0.1` radians becoming `0.10000000000000002`.
	enum CodingKeys: CodingKey {
		case radians
	}
	
	public init(from decoder: Decoder) throws {
		self.init()
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.radians = try container.decode(CGFloat.self, forKey: .radians)
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(radians, forKey: .radians)
	}
	
}
