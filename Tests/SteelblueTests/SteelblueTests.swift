import XCTest
@testable import Steelblue

final class SteelblueTests: XCTestCase {

    var secureStoreWithGenericPwd: Steelblue!
    var secureStoreWithInternetPwd: Steelblue!

    override func setUpWithError() throws {
        try super.setUpWithError()

        let genericPwdQueryable = GenericPasswordQueryable(service: "someService")
        secureStoreWithGenericPwd = Steelblue(secureStoreQueryable: genericPwdQueryable)

        let internetPwdQueryable = InternetPasswordQueryable(server: "someServer",
                                                             port: 8080,
                                                             path: "somePath",
                                                             securityDomain: "someDomain",
                                                             internetProtocol: .https,
                                                             internetAuthenticationType: .httpBasic)
        secureStoreWithInternetPwd = Steelblue(secureStoreQueryable: internetPwdQueryable)
    }

    override func tearDownWithError() throws {
        try secureStoreWithGenericPwd.removeAll()
        try secureStoreWithInternetPwd.removeAll()

        try super.tearDownWithError()
    }

    func testSaveAndReadGenericPassword() {
        do {
            try secureStoreWithGenericPwd.set(value: "pwd_1234", for: "genericPassword2")
            let password = try secureStoreWithGenericPwd.get(for: "genericPassword2")
            XCTAssertEqual("pwd_1234", password)
        } catch (let e) {
            XCTFail("Reading generic password failed with \(e.localizedDescription).")
        }
    }

    func testUpdateGenericPassword() {
        do {
            try secureStoreWithGenericPwd.set(value: "pwd_1234", for: "genericPassword2")
            try secureStoreWithGenericPwd.set(value: "pwd_1235", for: "genericPassword2")
            let password = try secureStoreWithGenericPwd.get(for: "genericPassword2")
            XCTAssertEqual("pwd_1235", password)
        } catch (let e) {
            XCTFail("Updating generic password failed with \(e.localizedDescription).")
        }
    }

    func testRemoveGenericPassword() {
        do {
            try secureStoreWithGenericPwd.set(value: "pwd_1234", for: "genericPassword2")
            try secureStoreWithGenericPwd.remove(for: "genericPassword2")
            XCTAssertNil(try secureStoreWithGenericPwd.get(for: "genericPassword2"))
        } catch (let e) {
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }

    func testRemoveAllGenericPasswords() {
        do {
            try secureStoreWithGenericPwd.set(value: "pwd_1234", for: "genericPassword")
            try secureStoreWithGenericPwd.set(value: "pwd_1235", for: "genericPassword2")
            
            try secureStoreWithGenericPwd.removeAll()
            XCTAssertNil(try secureStoreWithGenericPwd.get(for: "genericPassword"))
            XCTAssertNil(try secureStoreWithGenericPwd.get(for: "genericPassword2"))
        } catch (let e) {
            XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
        }
    }

    func testSaveAndReadInternetPassword() {
        do {
            try secureStoreWithInternetPwd.set(value: "pwd_1234", for: "internetPassword")
            let password = try secureStoreWithInternetPwd.get(for: "internetPassword")
            XCTAssertEqual("pwd_1234", password)
        } catch (let e) {
            XCTFail("Reading internet password failed with \(e.localizedDescription).")
        }
    }

    func testUpdateInternetPassword() {
        do {
            try secureStoreWithInternetPwd.set(value: "pwd_1234", for: "internetPassword")
            try secureStoreWithInternetPwd.set(value: "pwd_1235", for: "internetPassword")
            let password = try secureStoreWithInternetPwd.get(for: "internetPassword")
            XCTAssertEqual("pwd_1235", password)
        } catch (let e) {
            XCTFail("Updating internet password failed with \(e.localizedDescription).")
        }
    }

    func testRemoveInternetPassword() {
        do {
            try secureStoreWithInternetPwd.set(value: "pwd_1234", for: "internetPassword")
            try secureStoreWithInternetPwd.remove(for: "internetPassword")
            XCTAssertNil(try secureStoreWithInternetPwd.get(for: "internetPassword"))
        } catch (let e) {
            XCTFail("Removing internet password failed with \(e.localizedDescription).")
        }
    }

    func testRemoveAllInternetPasswords() {
        do {
            try secureStoreWithInternetPwd.set(value: "pwd_1234", for: "internetPassword")
            try secureStoreWithInternetPwd.set(value: "pwd_1235", for: "internetPassword2")
            try secureStoreWithInternetPwd.removeAll()
            XCTAssertNil(try secureStoreWithInternetPwd.get(for: "internetPassword"))
            XCTAssertNil(try secureStoreWithInternetPwd.get(for: "internetPassword2"))
        } catch (let e) {
            XCTFail("Removing internet passwords failed with \(e.localizedDescription).")
        }
    }

    static var allTests = [
        ("testSaveAndReadGenericPassword", testSaveAndReadGenericPassword),
        ("testUpdateGenericPassword", testUpdateGenericPassword),
        ("testRemoveGenericPassword", testRemoveGenericPassword),
        ("testRemoveAllGenericPasswords", testRemoveAllGenericPasswords),
        ("testSaveAndReadInternetPassword", testSaveAndReadInternetPassword),
        ("testUpdateInternetPassword", testUpdateInternetPassword),
        ("testRemoveInternetPassword", testRemoveInternetPassword),
        ("testRemoveAllInternetPasswords", testRemoveAllInternetPasswords)
    ]
}
