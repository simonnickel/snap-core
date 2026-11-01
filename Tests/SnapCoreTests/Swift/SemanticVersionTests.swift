//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Testing
@testable import SnapCore

@Suite
struct SemanticVersionTests {

	struct TestCase: Sendable, CustomTestStringConvertible {
		let string: String
		let expected: String
		let version: SemanticVersion

		static let positive: [TestCase] = [
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

		static let negative: [String] = [
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

		var testDescription: String { "Version: \(version.string), String: \(string)" }
	}

	@Test(arguments: TestCase.positive)
	func initFromString(test: TestCase) {
		#expect(SemanticVersion(test.string) == test.version)
	}

	@Test(arguments: TestCase.negative)
	func initFromInvalidString(string: String) {
		#expect(SemanticVersion(string) == nil)
	}

	@Test(arguments: TestCase.positive)
	func toString(test: TestCase) {
		#expect(test.version.string == test.expected)
	}

	@Test(arguments: ["0.0.0", "12.13.14"])
	func compareEqual(string: String) throws {
		let version = try #require(SemanticVersion(string))

		#expect(version == SemanticVersion(string))
	}

	@Test(arguments: ["11.13.14", "12.12.14", "12.13.13"])
	func compareLower(string: String) throws {
		let lower = try #require(SemanticVersion(string))
		let higher = try #require(SemanticVersion("12.13.14"))

		#expect(lower < higher)
	}

}
