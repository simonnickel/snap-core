//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

/// Extends `Font.Design` to be `Codable`.
extension Font.Design: @retroactive Codable {
	
	enum CodingKeys: CodingKey {
		case `default`, serif, rounded, monospaced
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let key = container.allKeys.first
		
		self = switch key {
			case .`default`: .default
			case .serif: .serif
			case .rounded: .rounded
			case .monospaced: .monospaced
			case .none:
				throw DecodingError.dataCorrupted(
					DecodingError.Context(
						codingPath: container.codingPath,
						debugDescription: "Unabled to decode enum."
					)
				)
		}
	}
	
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		switch self {
			case .`default`: try container.encode(true, forKey: .default)
			case .serif: try container.encode(true, forKey: .serif)
			case .rounded: try container.encode(true, forKey: .rounded)
			case .monospaced: try container.encode(true, forKey: .monospaced)
			@unknown default:
				throw DecodingError.dataCorrupted(
					DecodingError.Context(
						codingPath: container.codingPath,
						debugDescription: "Unknown value of Font.Design enum."
					)
				)
		}
	}
	
}
