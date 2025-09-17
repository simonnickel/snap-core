//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

/// Extends `Angle` to be `Codable`.
extension Angle: @retroactive Codable {
	
	enum CodingKeys: CodingKey {
		case radians
		case degrees
	}
	
	public init(from decoder: Decoder) throws {
		self.init()
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.radians = try container.decode(CGFloat.self, forKey: .radians)
		self.degrees = try container.decode(CGFloat.self, forKey: .degrees)
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(radians, forKey: .radians)
		try container.encode(degrees, forKey: .degrees)
	}
	
}
