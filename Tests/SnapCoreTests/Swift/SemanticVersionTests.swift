import XCTest
@testable import SnapCore

final class SemanticVersionTests: XCTestCase {
	
	private struct TestCase {
		let string: String
		let expected: String
		let version: SemanticVersion
		
		static var positive: [TestCase] = [
			TestCase(string: "12.13.14", expected: "12.13.14", version: SemanticVersion(major: 12, minor: 13, patch: 14)),
			TestCase(string: "12.13.14.", expected: "12.13.14", version: SemanticVersion(major: 12, minor: 13, patch: 14)),
			TestCase(string: "12.13.14.15", expected: "12.13.14", version: SemanticVersion(major: 12, minor: 13, patch: 14)),
			TestCase(string: "12.13.14.rc", expected: "12.13.14", version: SemanticVersion(major: 12, minor: 13, patch: 14)),
			TestCase(string: "12.13", expected: "12.13.0", version: SemanticVersion(major: 12, minor: 13, patch: 0)),
			TestCase(string: "12.13.", expected: "12.13.0", version: SemanticVersion(major: 12, minor: 13, patch: 0)),
			TestCase(string: "12..14", expected: "12.0.14", version: SemanticVersion(major: 12, minor: 0, patch: 14)),
			TestCase(string: "12", expected: "12.0.0", version: SemanticVersion(major: 12, minor: 0, patch: 0)),
			TestCase(string: "12.", expected: "12.0.0", version: SemanticVersion(major: 12, minor: 0, patch: 0)),
		]
		
		static var negative: [String] = [
			".",
			"",
			"a",
			"12a.13.14",
			"12.13.14-rc",
			"a.13.14",
			"12.a.14",
			"12.13.a",
			"12.a",
		]
		
		var description: String { "Version: \(version.string), String: \(string)" }
	}
	
	func testInitFromString() {
		for test in TestCase.positive {
			XCTAssertEqual(SemanticVersion(test.string), test.version, test.description)
		}
		
		for test in TestCase.negative {
			XCTAssertEqual(SemanticVersion(test), nil, test)
		}
	}
	
	func testToString() {
		for test in TestCase.positive {
			XCTAssertEqual(test.version.string, test.expected, test.description)
		}
	}
	
	func testCompare() {
		XCTAssert(SemanticVersion("0.0.0") == SemanticVersion("0.0.0"))
		XCTAssert(SemanticVersion("12.13.14") == SemanticVersion("12.13.14"))
		XCTAssert(SemanticVersion("11.13.14")! < SemanticVersion("12.13.14")!)
		XCTAssert(SemanticVersion("12.12.14")! < SemanticVersion("12.13.14")!)
		XCTAssert(SemanticVersion("12.13.13")! < SemanticVersion("12.13.14")!)
	}
	
}
