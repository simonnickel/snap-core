//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation

/// A data type to represent a Semantic Version.
/// See https://semver.org for details about semantic versioning.
public struct SemanticVersion: Hashable, Comparable, Equatable, Codable, RawRepresentable {
	
	public typealias RawValue = String
	public var rawValue: String { string }
	
	public let major: UInt
	public let minor: UInt
	public let patch: UInt
	
	public init(major: UInt, minor: UInt, patch: UInt) {
		self.major = major
		self.minor = minor
		self.patch = patch
	}
	
	public init?(_ string: String) {
		self.init(rawValue: string)
	}
	
	public init?(rawValue: String) {
		let split = rawValue.split(separator: ".", omittingEmptySubsequences: false)
		
		guard split.count > 0 && UInt(split[0]) != nil
		else { return nil }
		
		guard split.count < 2 || split[1] == "" || (split.count > 1 && UInt(split[1]) != nil)
		else { return nil }
		
		guard split.count < 3 || split[2] == "" || (split.count > 2 && UInt(split[2]) != nil)
		else { return nil }
		
		self.major = split.count > 0 ? UInt(split[0]) ?? 0 : 0
		self.minor = split.count > 1 ? UInt(split[1]) ?? 0 : 0
		self.patch = split.count > 2 ? UInt(split[2]) ?? 0 : 0
	}
	
	public var string: String { "\(major).\(minor).\(patch)" }
	
	public static func < (lhs: SemanticVersion, rhs: SemanticVersion) -> Bool {
		if lhs.major == rhs.major {
			if lhs.minor == rhs.minor {
				return lhs.patch < rhs.patch
			} else {
				return lhs.minor < rhs.minor
			}
		} else {
			return lhs.major < rhs.major
		}
	}
}
