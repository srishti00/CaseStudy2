//
//  SignUpViewController.swift
//  CaseStudy2
//
//  Created by Capgemini-DA204 on 9/21/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    //MARK: IBOutelt start
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var signUpUserNameTextField: UITextField!
    @IBOutlet weak var signUpEmailIDTextField: UITextField!
    @IBOutlet weak var signUpMobileTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    @IBOutlet weak var signUpConfirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpButtonLabel: UIButton!
    
    //MARK: IBOotlet end
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //adjust size of logo image
        logoImageView.layer.masksToBounds = false
        logoImageView.layer.cornerRadius = logoImageView.frame.height/2
        logoImageView.clipsToBounds = true
        
        signUpButtonLabel.layer.cornerRadius = 10
        self.navigationItem.hidesBackButton = true
    }
    
    //MARK: IBAction
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        //perfrom textfield validation
        let isValidName = self.userNameValidation(userName: signUpUserNameTextField.text!)
        let isValidEmail = self.emailIdValidation(emailId: signUpEmailIDTextField.text!)
        let isValidMobile = self.mobileValidation(mobile: signUpMobileTextField.text!)
        let isValidPassword = self.passwordValidation(password: signUpPasswordTextField.text!)
        let isValidRePassword = self.confirmPasswordValidation(rePassword: signUpPasswordTextField.text!, password: signUpConfirmPasswordTextField.text!)
        
        if isValidName && isValidEmail && isValidMobile && isValidPassword && isValidRePassword {
            //function calling to store data in firebase
            storeDataInFirebaseDatabase(emailId: signUpEmailIDTextField.text!, password: signUpPasswordTextField.text!)
        }
    }
    
    //MARK: Function to create user through Firebase
    
    func storeDataInFirebaseDatabase(emailId: String, password: String) {

        //Firebase authentication function to create user with emailId and password
        Auth.auth().createUser(withEmail: emailId, password: password, completion: {
            (result,error) in
                //if there is some error while creating user it will show alert
                if let error = error as NSError? {
                    let msg = self.showErrorMsg(error: error)
                    self.showAlert(msg: msg)
                }
            
                else {
                   //store user data in core data
                    DBManager.sharedDBMangerInstance().insertRecordInUser(uName: self.signUpUserNameTextField.text!, uEmail: emailId, uMobile: Int64(self.signUpMobileTextField.text!)!, uPassword: password)
                    
                    //after storing data navigate to home tab view controller
                    let homeTabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabViewController") as! HomeTabViewController
                    
                    //setting current user email Id for further process
                    homeTabBarVC.currentUserEmailId = self.signUpEmailIDTextField.text
                    self.navigationController?.pushViewController(homeTabBarVC, animated: true)
           }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
