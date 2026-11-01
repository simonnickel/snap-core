//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation
import Testing
import SwiftUI
@testable import SnapCore

@Suite
struct UnitPointCodableTests {

	@Test(arguments: [
		UnitPoint(x: 0.5, y: 0.5),
		UnitPoint(),
	])
	func roundTrip(unitPoint: UnitPoint) throws {
		let data = try JSONEncoder().encode(unitPoint)
		let decoded = try JSONDecoder().decode(UnitPoint.self, from: data)

		#expect(unitPoint == decoded)
	}

}
