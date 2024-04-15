import XCTest
@testable import SnapCore

final class SetInsertedTests: XCTestCase {
	
	func testSetInserted() {
		let someSet: Set<String> = ["Value 1"]
		let someSetInserted = someSet.inserted("Value 2")
		let someSetInsertedMultiple = someSet.inserted(["Value 2", "Value 3"])
		
		XCTAssertEqual(someSet.count, 1)
		XCTAssertEqual(someSetInserted.count, 2)
		XCTAssertEqual(someSetInsertedMultiple.count, 3)
		XCTAssertNotEqual(someSet, someSetInserted)
		XCTAssertNotEqual(someSet, someSetInsertedMultiple)
		
	}
	
}
