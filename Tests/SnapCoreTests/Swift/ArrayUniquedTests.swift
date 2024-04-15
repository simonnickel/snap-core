import XCTest
@testable import SnapCore

final class ArrayUniquedTests: XCTestCase {
	
	func testArrayUnique() {
		let arrayEmpty: [String] = []
		let arrayUnique: [String] = ["Value 1", "Value 2"]
		let arrayDuplicates: [String] = ["Value 1", "Value 1", "Value 2", "Value 2", "Value 3"]
		let arrayDuplicatesExpectedUniqued: [String] = ["Value 1", "Value 2", "Value 3"]
		
		XCTAssertEqual(arrayEmpty, arrayEmpty.uniqued())
		XCTAssertEqual(arrayUnique, arrayUnique.uniqued())
		XCTAssertNotEqual(arrayDuplicates, arrayDuplicates.uniqued())
		XCTAssertNotEqual(arrayDuplicates.count, arrayDuplicates.uniqued().count)
		XCTAssertEqual(arrayDuplicates.uniqued(), arrayDuplicatesExpectedUniqued)
	}
	
	func testArrayAppendUnique() {
		var arrayUnique: [String] = ["Value 1", "Value 2"]
		arrayUnique.appendUnique("Value 1")
		XCTAssertEqual(arrayUnique.count, 2)
		
		let arrayAppended: [String] = ["Value 1", "Value 2", "Value 3"]
		arrayUnique.appendUnique(arrayAppended)
		
		XCTAssertEqual(arrayUnique.count, 3)
		XCTAssertEqual(arrayUnique, arrayAppended)
	}
	
	func testArrayAppendedUnique() {
		let arrayUnique: [String] = ["Value 1", "Value 2"]
		let arrayDuplicates: [String] = ["Value 1", "Value 1", "Value 2", "Value 2", "Value 3"]
		
		XCTAssertEqual(arrayUnique.appendedUnique(arrayUnique).count, 2)
		XCTAssertEqual(arrayUnique.appendedUnique("Value 1").count, 2)
		XCTAssertEqual(arrayUnique, arrayUnique.appendedUnique(arrayUnique))
		XCTAssertNotEqual(arrayUnique, arrayUnique.appendedUnique(arrayDuplicates))
		XCTAssertEqual(arrayUnique.appendedUnique(arrayDuplicates).count, 3)
	}
	
}
