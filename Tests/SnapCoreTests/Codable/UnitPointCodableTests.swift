//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Foundation
import Testing
import SwiftUI
@testable import SnapCore

struct UnitPointCodableTests {

	@Test(arguments: [
		UnitPoint(x: 0.25, y: 0.75),
		UnitPoint(),
	])
	func roundTrip(unitPoint: UnitPoint) throws {
		let data = try JSONEncoder().encode(unitPoint)
		let decoded = try JSONDecoder().decode(UnitPoint.self, from: data)

		#expect(decoded == unitPoint)
	}

}
