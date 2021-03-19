import XCTest
@testable import Steelblue

final class SteelblueTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Steelblue().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
