//
//  UnitPoint+Codable.swift
//  SnapCore
//
//  Created by Simon Nickel on 07.11.23.
//

import SwiftUI

/// Extends `UnitPoint` to be `Codable`.
extension UnitPoint: Codable {
	
	enum CodingKeys: CodingKey {
		case x
		case y
	}
	
	public init(from decoder: Decoder) throws {
		self.init()
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.x = try container.decode(CGFloat.self, forKey: .x)
		self.y = try container.decode(CGFloat.self, forKey: .y)
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(x, forKey: .x)
		try container.encode(y, forKey: .y)
	}
	
}
