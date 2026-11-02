//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Testing
import SwiftUI
@testable import SnapCore

struct ColorAdjustTests {

	// MARK: - HSBA

	@Test(arguments: [
		(Color.black, Color.HSBA(hue: 0, saturation: 0, brightness: 0, alpha: 1)),
		(Color.white, Color.HSBA(hue: 0, saturation: 0, brightness: 1, alpha: 1)),
		(Color(red: 0, green: 0, blue: 1), Color.HSBA(hue: 2.0 / 3.0, saturation: 1, brightness: 1, alpha: 1)),
	])
	func getHSBA(color: Color, expected: Color.HSBA) {
		#expect(color.getHSBA(in: EnvironmentValues()).isClose(to: expected))
	}

	@Test
	func colorFromHSBA() {
		let hsba = Color.HSBA(hue: 0.25, saturation: 0.5, brightness: 0.75, alpha: 0.6)
		let environment = EnvironmentValues()

		#expect(Color(hsba).getHSBA(in: environment).isClose(to: hsba))
		#expect(hsba.color.getHSBA(in: environment).isClose(to: hsba))
	}

	// MARK: - Adjust

	private static let base = Color(hue: 0.5, saturation: 0.5, brightness: 0.5, opacity: 0.5)

	@Test
	func adjustedWithoutValuesKeepsColor() {
		let environment = EnvironmentValues()
		let expected = Color.HSBA(hue: 0.5, saturation: 0.5, brightness: 0.5, alpha: 0.5)

		#expect(Self.base.adjusted(in: environment).getHSBA(in: environment).isClose(to: expected))
		#expect(Self.base.adjusted(nil, in: environment).getHSBA(in: environment).isClose(to: expected))
	}

	/// Each case changes one value, so a value applied to the wrong component fails.
	@Test(arguments: [
		(Color.Adjustment(hue: .add(0.25)), Color.HSBA(hue: 0.75, saturation: 0.5, brightness: 0.5, alpha: 0.5)),
		(Color.Adjustment(saturation: .multiply(0.5)), Color.HSBA(hue: 0.5, saturation: 0.25, brightness: 0.5, alpha: 0.5)),
		(Color.Adjustment(brightness: .replace(0.75)), Color.HSBA(hue: 0.5, saturation: 0.5, brightness: 0.75, alpha: 0.5)),
		(Color.Adjustment(alpha: .replace(1)), Color.HSBA(hue: 0.5, saturation: 0.5, brightness: 0.5, alpha: 1)),
	])
	func adjusted(adjustment: Color.Adjustment, expected: Color.HSBA) {
		let environment = EnvironmentValues()

		#expect(Self.base.adjusted(adjustment, in: environment).getHSBA(in: environment).isClose(to: expected))
	}

}


// MARK: - Helper

private extension Color.HSBA {

	/// Resolving a color converts its values, which introduces small floating point differences.
	func isClose(to other: Color.HSBA) -> Bool {
		let tolerance = 0.001

		return abs(hue - other.hue) < tolerance
		&& abs(saturation - other.saturation) < tolerance
		&& abs(brightness - other.brightness) < tolerance
		&& abs(alpha - other.alpha) < tolerance
	}

}
