//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Testing
@testable import SnapCore

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
			TestCase(string: "0.0.0", expected: "0.0.0", version: SemanticVersion(major: 0, minor: 0, patch: 0)),
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
			".13.14",
			"-1.13.14",
			"12.-1.14",
			"12.13.-1",
		]

		var testDescription: String { "Version: \(version.string), String: \(string)" }
	}

	@Test(arguments: TestCase.positive)
	func initFromString(test: TestCase) {
		#expect(SemanticVersion(test.string) == test.version)
		#expect(SemanticVersion(rawValue: test.string) == test.version)
	}

	@Test(arguments: TestCase.negative)
	func initFromInvalidString(string: String) {
		#expect(SemanticVersion(string) == nil)
		#expect(SemanticVersion(rawValue: string) == nil)
	}

	@Test(arguments: TestCase.positive)
	func toString(test: TestCase) {
		#expect(test.version.string == test.expected)
		#expect(test.version.rawValue == test.expected)
	}

	@Test(arguments: ["0.0.0", "12.13.14"])
	func compareEqual(string: String) throws {
		let version = try #require(SemanticVersion(string))
		let other = try #require(SemanticVersion(string))

		#expect(version == other)
		#expect(!(version < other))
	}

	/// The cases include a lower version with higher later components, and values that sort differently as text.
	@Test(arguments: [
		("11.13.14", "12.13.14"),
		("12.12.14", "12.13.14"),
		("12.13.13", "12.13.14"),
		("11.99.99", "12.0.0"),
		("12.12.99", "12.13.0"),
		("9.0.0", "10.0.0"),
	])
	func compareLower(lowerString: String, higherString: String) throws {
		let lower = try #require(SemanticVersion(lowerString))
		let higher = try #require(SemanticVersion(higherString))

		#expect(lower < higher)
		#expect(!(higher < lower))
	}

}
