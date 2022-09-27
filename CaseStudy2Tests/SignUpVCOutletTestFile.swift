//
//  SignUpVCOutletTestFile.swift
//  CaseStudy2Tests
//
//  Created by Capgemini-DA204 on 9/27/22.
//

import XCTest
@testable import CaseStudy2

class SignUpVCOutletTestFile: XCTestCase {

    var signUpVC: SignUpViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        signUpVC.loadView()
    }
    
    func testSignUpVCOutlet() throws {
        let userName = try  XCTUnwrap(signUpVC.signUpUserNameTextField, "User Name field is not connected to outlet")
        let userEmail = try XCTUnwrap(signUpVC.signUpEmailIDTextField, "Email Field is not connected to outlet")
        let userMobile = try XCTUnwrap(signUpVC.signUpMobileTextField, "Mobile Field is not connected to outlet")
        let userPassword = try XCTUnwrap(signUpVC.signUpPasswordTextField, "Password Field is not connected to outlet")
        let rePassword = try XCTUnwrap(signUpVC.signUpConfirmPasswordTextField, "Confirm Password Field is not connected to outlet")
        
        XCTAssertTrue(userName.isUserInteractionEnabled, "User Interaction is disabled")
        XCTAssertTrue(userMobile.isUserInteractionEnabled, "User Interaction is disabled")
        XCTAssertTrue(userEmail.isUserInteractionEnabled, "User Interaction is disabled")
        XCTAssertTrue(userPassword.isUserInteractionEnabled, "User Interaction is disabled")
        XCTAssertTrue(rePassword.isUserInteractionEnabled, "User Interaction is disabled")
        
        XCTAssertTrue(userPassword.isSecureTextEntry, "Secure text entry is disable")
        XCTAssertTrue(rePassword.isSecureTextEntry, "Secure text entry is disable")
        
        XCTAssertEqual(userEmail.keyboardType, UIKeyboardType.emailAddress, "Keyboard type is not email address")
        XCTAssertEqual(userMobile.keyboardType, UIKeyboardType.phonePad, "Keyboard type is not phone pad")
        
        let signUpBtn = try XCTUnwrap(signUpVC.signUpButtonLabel, "Sign up button is not connected to outlet")
        let signUpAction = try XCTUnwrap(signUpBtn.actions(forTarget: signUpVC, forControlEvent: .touchUpInside))
        XCTAssertEqual(signUpAction.first , "signUpButtonClicked:", "No such action for sign up button")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
