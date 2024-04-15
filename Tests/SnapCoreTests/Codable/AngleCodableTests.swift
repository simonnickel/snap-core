import XCTest
import SwiftUI
@testable import SnapCore

final class AngleCodableTests: XCTestCase {
	
	func testAngleDegrees() {
		let angleDegrees = Angle(degrees: 0.5)
		
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(angleDegrees)
			
			let decoder = JSONDecoder()
			let decoded = try decoder.decode(Angle.self, from: data)
			
			XCTAssertEqual(angleDegrees, decoded)
		} catch {
			XCTFail()
		}
	}
	
	func testAngleRadians() {
		let angleRadians = Angle(radians: 0.5)
		
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(angleRadians)
			
			let decoder = JSONDecoder()
			let decoded = try decoder.decode(Angle.self, from: data)
			
			XCTAssertEqual(angleRadians, decoded)
		} catch {
			XCTFail()
		}
	}
	
}
	
