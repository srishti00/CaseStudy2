//
//  LoginOutletTestFile.swift
//  CaseStudy2Tests
//
//  Created by Capgemini-DA204 on 9/27/22.
//

import XCTest
@testable import CaseStudy2

class LoginOutletTestFile: XCTestCase {

    var loginVC: LoginViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        loginVC.loadView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginVCOutlet() throws {
        let userEmail = try XCTUnwrap(loginVC.loginEmailIdTextField, "Email Field is not connected to outlet")
        let userPassword = try XCTUnwrap(loginVC.loginPasswordTextField, "Password Field is not connected to outlet")
        
        XCTAssertTrue(userEmail.isUserInteractionEnabled, "User Interaction is disabled")
        XCTAssertTrue(userPassword.isUserInteractionEnabled, "User Interaction is disabled")
        
        XCTAssertTrue(userPassword.isSecureTextEntry, "Secure text entry is disable")
        
        XCTAssertEqual(userEmail.keyboardType, UIKeyboardType.emailAddress, "Keyboard type is not email address")
        
        let loginBtn = try XCTUnwrap(loginVC.loginButtonLabel, "Login button is not connected to outlet")
        let loginAction = try XCTUnwrap(loginBtn.actions(forTarget: loginVC, forControlEvent: .touchUpInside))
        XCTAssertEqual(loginAction.first , "loginButtonClicked:", "No such action for login button")
        
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
