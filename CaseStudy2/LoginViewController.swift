//
//  ViewController.swift
//  CaseStudy2
//
//  Created by Capgemini-DA204 on 9/20/22.
//

import UIKit
import Alamofire
import LocalAuthentication
import FirebaseAuth

class LoginViewController: UIViewController {

    //MARK: IBOutlet start
    
    @IBOutlet weak var loginEmailIdTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginButtonLabel: UIButton!
    @IBOutlet weak var signUpButtonLabel: UIButton!
    
    //MARK: IBOutlet end
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        logoImageView.layer.masksToBounds = false
        logoImageView.layer.cornerRadius = logoImageView.frame.height/2
        logoImageView.clipsToBounds = true
  
        loginButtonLabel.layer.cornerRadius = 10
        signUpButtonLabel.layer.cornerRadius = 10
        
        authenticationByFaceId()
    }
    
    //MARK: Function for authentication by Face Id
    
    //take LAContext and if biometrics available start authentication for faceID
    func authenticationByFaceId() {
        let context = LAContext()
        var authError: NSError!
        
        //check if biometric authentcation available for device or not
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authenticate to open the app", reply: {
                (success, error) in
                DispatchQueue.main.async {
                    if success {
                        //if face matched show alert for successful authentication
                        self.showAlert(msg: "Authenticate Successfully")
                    }
                    else {
                        //if face not matched show alert showing error
                        if let error = error {
                            self.showAlert(msg: "Authentication Faild \(error)")
                        }
                    }
                }
            })
        }
        else {
            //if no biometrics available show alert
            self.showAlert(msg: "No biometrics Available")
        }
        
    }
    
    //MARK: IBAction
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        let emailId = loginEmailIdTextField.text!
        let password = loginPasswordTextField.text!
        if emailId.isEmpty {
            self.showAlert(msg: "Email Id cannot be empty")
        }
        //For login with emailId and password Firebase Authentication Used
        Auth.auth().signIn(withEmail: emailId , password: password) { (result, error) in
            
            //if there is some error on signing in it will show alert with message
            if let error = error as NSError? {
                let msg = self.showErrorMsg(error: error)
                self.showAlert(msg: msg)
            }
            
            else {
                do {
                    //logout previous user from key chain
                    KeyChain.logout()
                    
                    //save current user data in keychain
                    try KeyChain.saveDataIntoKeychain(emailId: emailId, password: password)
                    
                    //if data saved successfully navigate to Home tab view controller
                    let homeTabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabViewController") as! HomeTabViewController
                    
                    //setting currentuser emailId
                    homeTabBarVC.currentUserEmailId = self.loginEmailIdTextField.text
                    self.navigationController?.pushViewController(homeTabBarVC, animated: true)
                } catch (let error) {
                    //if there is error while saving data in keychain it will show alert
                    self.showAlert(msg: "Login Failed, \(error)")
                }
            }
        }
    }
}

//MARK: Keychain Class

class KeyChain {
    
    enum KeyChainError: Error {
        case noPassword
        case unhandledError(status: OSStatus)
    }
    
    //function to save data. It will throw error if there data couldn't saved
    static func saveDataIntoKeychain(emailId: String, password: String) throws{
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: emailId,
            kSecValueData as String: password.data(using: String.Encoding.utf8)!
        ] as [String: Any]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeyChainError.unhandledError(status: status)
        }
    }
    
    //function to delete data from keychain when user logout from application
    static func logout() {
        let secItemClasses = [
            kSecClassGenericPassword,
            kSecClassCertificate,
            kSecClassKey,
            kSecClassIdentity
        ]
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }
}


