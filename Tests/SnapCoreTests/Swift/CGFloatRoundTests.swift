import XCTest
@testable import SnapCore

final class CGFloatRoundTests: XCTestCase {
	
	func testCGFloatRound() {
		
		// Round correct number of decimals
		XCTAssertEqual(CGFloat(1.234567).round(decimals: 2), CGFloat(1.23))
		XCTAssertNotEqual(CGFloat(1.234567).round(decimals: 2), CGFloat(1.231))
		
		// Respect rounding rule
		XCTAssertEqual(CGFloat(1.234567).round(decimals: 2, rule: .up), CGFloat(1.24))
		
		// Lower edge
		XCTAssertEqual(CGFloat(1.234567).round(decimals: 0), CGFloat(1))
		
		// Upper edge
		XCTAssertEqual(CGFloat(1.234567).round(decimals: 10), CGFloat(1.234567))
		
		// Other edge
		XCTAssertEqual(CGFloat(0).round(decimals: 1), CGFloat())
		
	}
	
}
