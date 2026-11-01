//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation
import Testing
import SwiftUI
@testable import SnapCore

@Suite
struct FontDesignCodableTests {

	@Test
	func roundTrip() throws {
		let design = Font.Design.monospaced

		let data = try JSONEncoder().encode(design)
		let decoded = try JSONDecoder().decode(Font.Design.self, from: data)

		#expect(design == decoded)
	}

}
