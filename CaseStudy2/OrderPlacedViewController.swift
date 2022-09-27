//
//  OrderPlacedViewController.swift
//  CaseStudy2
//
//  Created by Capgemini-DA204 on 9/26/22.
//

import UIKit

class OrderPlacedViewController: UIViewController {

    //MARK: IBOutlet start
    
    @IBOutlet weak var backToShoppingButtonLabel: UIButton!
    
    //MARK: IBOutlet end
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        backToShoppingButtonLabel.layer.cornerRadius = 10
    }
    
    //MARK: IBAction
    
    @IBAction func backToShoppingButtonClicked(_ sender: Any) {
        //navigate to home tab view controller
        let catVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeTabViewController") as! HomeTabViewController
        
        //setting current user email id for home tab view controller
        catVC.currentUserEmailId = currentUser?.userEmailId
        self.navigationController?.pushViewController(catVC, animated: true)
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
