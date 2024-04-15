import XCTest
import SwiftUI
@testable import SnapCore

final class UnitPointCodableTests: XCTestCase {
	
	func testUnitPointValues() {
		let unitPoint = UnitPoint(x: 0.5, y: 0.5)
		
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(unitPoint)
			
			let decoder = JSONDecoder()
			let decoded = try decoder.decode(UnitPoint.self, from: data)
			
			XCTAssertEqual(unitPoint, decoded)
		} catch {
			XCTFail()
		}
	}
	
	func testUnitPoint() {
		let unitPoint = UnitPoint()
		
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(unitPoint)
			
			let decoder = JSONDecoder()
			let decoded = try decoder.decode(UnitPoint.self, from: data)
			
			XCTAssertEqual(unitPoint, decoded)
		} catch {
			XCTFail()
		}
	}
	
}
	
