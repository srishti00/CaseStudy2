//
//  VaildationExtension.swift
//  CaseStudy2
//
//  Created by Capgemini-DA204 on 9/21/22.
//

import Foundation
import UIKit
import Alamofire
import FirebaseAuth

extension UIViewController {
    
    //MARK: User Name Validation
    
    //validate user name. It should have atleast 4 letters.
    func userNameValidation(userName: String) -> Bool {
        if userName.isEmpty {
            showAlert(msg: "Name field can not be empty")
            return false
        }
        if userName.count < 4 {
            showAlert(msg: "Invalid Name")
            return false
        }
        return true
    }
    
    //MARK: Email ID Validation
    
    func emailIdValidation(emailId: String) -> Bool {
        if emailId.isEmpty {
            showAlert(msg: "EmailId field can not be empty")
            return false
        }
        let regEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        let validEmail = NSPredicate(format: "SELF MATCHES %@", regEx)
        if !validEmail.evaluate(with: emailId) {
            showAlert(msg: "Invalid EmailId")
            return false
        }
        return true
    }
    
    //MARK: Mobile Validation
    
    //validate mobile field. It should have 10 digits
    func mobileValidation(mobile: String) -> Bool{
        if mobile.isEmpty {
            showAlert(msg: "Mobile field can not be empty")
            return false
        }
        let regEx = "^[0-9]{10}$"
        let validMobile = NSPredicate(format: "SELF MATCHES %@", regEx)
        if !validMobile.evaluate(with: mobile) {
            showAlert(msg: "Invalid Mobile")
            return false
        }
        return true
    }
    
    //MARK: Password Validation Function
   
    func passwordValidation(password: String) -> Bool {
        if password.isEmpty {
            showAlert(msg: "Password field can not be empty")
            return false
        }
        let regEx = "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{6,}"
        let validpassword = NSPredicate(format: "SELF MATCHES %@", regEx)
        if !validpassword.evaluate(with: password) {
            showAlert(msg: "Invalid Password")
            return false
        }
        return true
    }
    
    //MARK: Confirm Password Validation Function
   
    func confirmPasswordValidation(rePassword: String, password: String) -> Bool {
        if password.isEmpty {
            showAlert(msg: "Password field can not be empty")
            return false
        }
        if rePassword.isEmpty {
            showAlert(msg: "Confirm Password field can not be empty")
            return false
        }
        else if rePassword != password {
            showAlert(msg: "Password not matched")
            return false
        }
        return true
    }
    
    //MARK: Show Alert Function
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
   
    //MARK: Firebase authentication error message function
    
    //function to show error message when signing in with firebase
    func showErrorMsg(error: NSError) -> String {
        var msg = ""
        guard let errorCode = AuthErrorCode.Code(rawValue: error.code) else {
            return "Something went wrong"
        }
        switch errorCode {
            case .emailAlreadyInUse:
                msg = "EmailId already exists"
                break
            case .userNotFound:
                msg = "User Not exists. Please Sign Up."
                break
            case .invalidEmail:
                msg = "Enter a vaild email"
                break
            case .weakPassword:
                 msg = "Invalid Password"
                break
            case .wrongPassword:
                msg = "Wrong password"
                break
            default:
                print("Error occured")
        }
        return msg
    }
}
