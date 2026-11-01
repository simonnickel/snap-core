//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Testing
import SwiftUI
@testable import SnapCore

@Suite
struct ColorAdjustTests {

	@Test
	func get() {
		let environment = EnvironmentValues()

		let black = Color.black
		let blackHSBA = black.getHSBA(in: environment)

		#expect(blackHSBA.hue == 0)
		#expect(blackHSBA.saturation == 0)
		#expect(blackHSBA.brightness == 0)

		let white = Color.white
		let whiteHSBA = white.getHSBA(in: environment)

		#expect(whiteHSBA.hue == 0)
		#expect(whiteHSBA.saturation == 0)
		#expect(whiteHSBA.brightness.rounded(.up) == 1)
	}

	@Test(arguments: [
		Color.black,
		Color.white,
		Color(hue: 0.5, saturation: 0.5, brightness: 0.5, opacity: 0.5),
		Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.5),
	])
	func initFromHSBA(color: Color) {
		let hsba = color.getHSBA(in: EnvironmentValues())

		#expect(Color(hsba) == color)
	}

//	@Test
//	func adjust() {
//		let environment = EnvironmentValues()
//
//		let black = Color(hue: 0, saturation: 0, brightness: 0)
//		let blackAdjusted = black.adjusted(hue: 0.1, saturation: 0.1, brightness: 0.1, in: environment)
//		let blackAdjustedBack = black.adjusted(hue: -0.1, saturation: -0.1, brightness: -0.1, in: environment)
//
//		#expect(black != blackAdjusted)
//		#expect(black == blackAdjustedBack)
//	}

}
