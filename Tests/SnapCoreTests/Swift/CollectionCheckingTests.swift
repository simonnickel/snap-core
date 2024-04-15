import XCTest
@testable import SnapCore

final class CollectionCheckingTests: XCTestCase {
	
	func testCollectionChecking() {
		let arrayEmpty: [Int] = []
		let array: [Int] = [1, 2, 3]
		
		XCTAssertNil(arrayEmpty[checking: 0])
		
		XCTAssertNotNil(array[checking: 0])
		XCTAssertNotNil(array[checking: array.count - 1])
		XCTAssertNil(array[checking: -1])
		XCTAssertNil(array[checking: array.count])
	}
	
}
