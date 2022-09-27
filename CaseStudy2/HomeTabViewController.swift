//
//  HomeViewController.swift
//  CaseStudy2
//
//  Created by Capgemini-DA204 on 9/23/22.
//

import UIKit
import FirebaseAuth

public var currentUser: User?
class HomeTabViewController: UITabBarController {
 
    //MARK: Variable
    
    var currentUserEmailId: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        self.navigationItem.hidesBackButton = true
        
        //set right button in the navigation bar for sign out functionality
        let rightButtonItem = UIBarButtonItem.init( title: "Sign Out", style: .done, target: self, action: #selector(rightButtonClicked))
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        //set images for tab bar item
        guard let items = self.tabBar.items else { return }
        self.tabBar.tintColor = UIColor.white
        let images = ["list.bullet.rectangle.fill","cart"]
        for x in 0...1 {
            items[x].image = UIImage(systemName: images[x])
        }
        
        //fetch current user data from current user email id.
        currentUser = DBManager.sharedDBMangerInstance().fetchRecordFromUser(uID: currentUserEmailId!)
    }
    
    //MARK: Selector function
    
    //when sign out button clicked
    @objc func rightButtonClicked(_ sender: Any) {
        
        do {
            //signout using firebase authentication
            try Auth.auth().signOut()
            
            //set login page as root view controller
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginNavigationViewController")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginVC)
             
            
        } catch (let error) {
            //if there is any error while logging out show alert with message
            self.showAlert(msg: "Cannot Sign Out: \(error.localizedDescription)")
        }
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
