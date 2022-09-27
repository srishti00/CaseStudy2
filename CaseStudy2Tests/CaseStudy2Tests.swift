//
//  CaseStudy2Tests.swift
//  CaseStudy2Tests
//
//  Created by Capgemini-DA204 on 9/20/22.
//

import XCTest
@testable import CaseStudy2

class CaseStudy2Tests: XCTestCase {

    let dbManager = DBManager()
    var vc: SignUpViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        vc.loadViewIfNeeded()
    }
    
    func testFetchMethods() {
        XCTAssertNotNil(dbManager.fetchRecordFormCart(), "Couldn't fetch data from cart entity")
        XCTAssertNotNil(dbManager.fetchRecord(), "Couldn't fetch data from user enity")
        dbManager.insertRecordInUser(uName: "Harry", uEmail: "harry@gmail.com", uMobile: 8765320912, uPassword: "Harry12")
        XCTAssertNotNil(dbManager.fetchRecordFromUser(uID: "harry@gmail.com"))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testKeyChainSaveData() {
        XCTAssertNoThrow(try KeyChain.saveDataIntoKeychain(emailId: "new1@gmail.com", password: "New12345"), "Couldn't save data in keychain")
    }
    
    func testValidationMethod() {
        XCTAssertTrue(vc.userNameValidation(userName: "Test"), "Name is not valid")
        XCTAssertTrue(vc.emailIdValidation(emailId: "test@gmail.com"), "Email Id is not valid")
        XCTAssertTrue(vc.mobileValidation(mobile: "6589210433"), "Mobile Number is not valid")
        XCTAssertTrue(vc.passwordValidation(password: "Test123"), "Password is not valid")
        XCTAssertTrue(vc.confirmPasswordValidation(rePassword: "Test", password: "Test"), "Password not matched")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
