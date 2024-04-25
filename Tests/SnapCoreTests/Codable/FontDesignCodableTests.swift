import XCTest
import SwiftUI
@testable import SnapCore

final class FontDesignCodableTests: XCTestCase {
	
	func testFontDesign() {
		let design = Font.Design.monospaced
		
		do {
			let encoder = JSONEncoder()
			let data = try encoder.encode(design)
			
			let decoder = JSONDecoder()
			let decoded = try decoder.decode(Font.Design.self, from: data)
			
			XCTAssertEqual(design, decoded)
		} catch {
			XCTFail()
		}
	}

}
