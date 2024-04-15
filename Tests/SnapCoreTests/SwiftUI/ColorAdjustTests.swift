import XCTest
@testable import SnapCore
import SwiftUI

final class ColorAdjustTests: XCTestCase {
	
	func testGet() {
		let environment = EnvironmentValues()
		
		let black = Color.black
		let blackHSBA = black.getHSBA(in: environment)
		
		XCTAssertEqual(blackHSBA.hue, 0)
		XCTAssertEqual(blackHSBA.saturation, 0)
		XCTAssertEqual(blackHSBA.brightness, 0)
		
		let white = Color.white
		let whiteHSBA = white.getHSBA(in: environment)
		
		XCTAssertEqual(whiteHSBA.hue, 0)
		XCTAssertEqual(whiteHSBA.saturation, 0)
		XCTAssertEqual(whiteHSBA.brightness.rounded(.up), 1)
	}
	
	func testInit() {
		let environment = EnvironmentValues()
		
		let black = Color.black
		let blackHSBA = black.getHSBA(in: environment)
		let colorBlack = Color(blackHSBA)
		
		XCTAssertEqual(colorBlack, black)
		
		let white = Color.white
		let whiteHSBA = white.getHSBA(in: environment)
		let colorWhite = Color(whiteHSBA)
		
		XCTAssertEqual(colorWhite, white)
		
		let custom = Color(hue: 0.5, saturation: 0.5, brightness: 0.5, opacity: 0.5)
		let customHSBA = custom.getHSBA(in: environment)
		let colorCustom = Color(customHSBA)
		
		XCTAssertEqual(colorCustom, custom)
		
		let custom2 = Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.5)
		let custom2HSBA = custom2.getHSBA(in: environment)
		let color2Custom = Color(custom2HSBA)
		
		XCTAssertEqual(color2Custom, custom2)
	}
	
//	func testAdjust() {
//		let environment = EnvironmentValues()
//		
//		let black = Color(hue: 0, saturation: 0, brightness: 0)
//		let blackAdjusted = black.adjusted(hue: 0.1, saturation: 0.1, brightness: 0.1, in: environment)
//		let blackAdjustedBack = black.adjusted(hue: -0.1, saturation: -0.1, brightness: -0.1, in: environment)
//		
//		XCTAssertNotEqual(black, blackAdjusted)
//		XCTAssertEqual(black, blackAdjustedBack)
//	}
	
}
