//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation
import Testing
import SwiftUI
@testable import SnapCore

struct AngleCodableTests {

	@Test(arguments: [
		Angle(degrees: 0.5),
		Angle(radians: 0.1),
	])
	func roundTrip(angle: Angle) throws {
		let data = try JSONEncoder().encode(angle)
		let decoded = try JSONDecoder().decode(Angle.self, from: data)

		#expect(decoded == angle)
	}

}
