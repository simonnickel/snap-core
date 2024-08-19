//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation

public extension String {
	
	/// Version of the string with an uppercased first letter.
	var uppercasedFirstLetter: String {
		return self.replacingCharacters(
			in: self.startIndex...self.startIndex,
			with: String(self[self.startIndex]).uppercased()
		)
	}
	
	/// Returns an array of subsequences separated by the given `CharacterSet`.
	///
	/// Convenince api because I always forget about `components(seperatedBy)`.
	/// - Parameter characterSet: CharacterSet to split the String by.
	/// - Returns: Array of substrings.
	func split(by characterSet: CharacterSet) -> [String] {
		components(separatedBy: characterSet)
	}
	
}
