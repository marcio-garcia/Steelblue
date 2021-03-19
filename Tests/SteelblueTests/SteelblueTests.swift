import XCTest
@testable import Steelblue

final class SteelblueTests: XCTestCase {

    var secureStoreWithGenericPwd: Steelblue!
    var secureStoreWithInternetPwd: Steelblue!

    override func setUpWithError() throws {
        super.setUp()

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
        try? secureStoreWithGenericPwd.removeAllValues()
        try? secureStoreWithInternetPwd.removeAllValues()

        super.tearDown()
    }

    func testSaveGenericPassword() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
        } catch (let e) {
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }

    func testReadGenericPassword() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
            let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
            XCTAssertEqual("pwd_1234", password)
        } catch (let e) {
            XCTFail("Reading generic password failed with \(e.localizedDescription).")
        }
    }

    func testUpdateGenericPassword() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
            try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword")
            let password = try secureStoreWithGenericPwd.getValue(for: "genericPassword")
            XCTAssertEqual("pwd_1235", password)
        } catch (let e) {
            XCTFail("Updating generic password failed with \(e.localizedDescription).")
        }
    }

    func testRemoveGenericPassword() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
            try secureStoreWithGenericPwd.removeValue(for: "genericPassword")
            XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
        } catch (let e) {
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }

    func testRemoveAllGenericPasswords() {
        do {
            try secureStoreWithGenericPwd.setValue("pwd_1234", for: "genericPassword")
            try secureStoreWithGenericPwd.setValue("pwd_1235", for: "genericPassword2")
            try secureStoreWithGenericPwd.removeAllValues()
            XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword"))
            XCTAssertNil(try secureStoreWithGenericPwd.getValue(for: "genericPassword2"))
        } catch (let e) {
            XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
        }
    }

    func testSaveInternetPassword() {
        do {
            try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
        } catch (let e) {
            XCTFail("Saving Internet password failed with \(e.localizedDescription).")
        }
    }

    func testReadInternetPassword() {
        do {
            try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
            let password = try secureStoreWithInternetPwd.getValue(for: "internetPassword")
            XCTAssertEqual("pwd_1234", password)
        } catch (let e) {
            XCTFail("Reading internet password failed with \(e.localizedDescription).")
        }
    }

    func testUpdateInternetPassword() {
        do {
            try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
            try secureStoreWithInternetPwd.setValue("pwd_1235", for: "internetPassword")
            let password = try secureStoreWithInternetPwd.getValue(for: "internetPassword")
            XCTAssertEqual("pwd_1235", password)
        } catch (let e) {
            XCTFail("Updating internet password failed with \(e.localizedDescription).")
        }
    }

    func testRemoveInternetPassword() {
        do {
            try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
            try secureStoreWithInternetPwd.removeValue(for: "internetPassword")
            XCTAssertNil(try secureStoreWithInternetPwd.getValue(for: "internetPassword"))
        } catch (let e) {
            XCTFail("Removing internet password failed with \(e.localizedDescription).")
        }
    }

    func testRemoveAllInternetPasswords() {
        do {
            try secureStoreWithInternetPwd.setValue("pwd_1234", for: "internetPassword")
            try secureStoreWithInternetPwd.setValue("pwd_1235", for: "internetPassword2")
            try secureStoreWithInternetPwd.removeAllValues()
            XCTAssertNil(try secureStoreWithInternetPwd.getValue(for: "internetPassword"))
            XCTAssertNil(try secureStoreWithInternetPwd.getValue(for: "internetPassword2"))
        } catch (let e) {
            XCTFail("Removing internet passwords failed with \(e.localizedDescription).")
        }
    }

    static var allTests = [
        ("testSaveGenericPassword", testSaveGenericPassword),
        ("testReadGenericPassword", testReadGenericPassword),
        ("testUpdateGenericPassword", testUpdateGenericPassword),
        ("testRemoveGenericPassword", testRemoveGenericPassword),
        ("testRemoveAllGenericPasswords", testRemoveAllGenericPasswords),
        ("testSaveInternetPassword", testSaveInternetPassword),
        ("testReadInternetPassword", testReadInternetPassword),
        ("testUpdateInternetPassword", testUpdateInternetPassword),
        ("testRemoveInternetPassword", testRemoveInternetPassword),
        ("testRemoveAllInternetPasswords", testRemoveAllInternetPasswords)
    ]
}
