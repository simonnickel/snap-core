//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation
import Testing
import SwiftUI
@testable import SnapCore

struct FontDesignCodableTests {

	@Test(arguments: [
		Font.Design.default,
		Font.Design.serif,
		Font.Design.rounded,
		Font.Design.monospaced,
	])
	func roundTrip(design: Font.Design) throws {
		let data = try JSONEncoder().encode(design)
		let decoded = try JSONDecoder().decode(Font.Design.self, from: data)

		#expect(decoded == design)
	}

	@Test
	func decodeWithoutKeyThrows() {
		#expect(throws: DecodingError.self) {
			try JSONDecoder().decode(Font.Design.self, from: Data("{}".utf8))
		}
	}

}
