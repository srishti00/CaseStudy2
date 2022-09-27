//
//  NotificationViewController.swift
//  CaseStudy2
//
//  Created by Capgemini-DA204 on 9/24/22.
//

import UIKit
import LocalNotificationFramework

public var productId: Int64?

class NotificationViewController: UIViewController, UNUserNotificationCenterDelegate {

    //MARK: IBOutlet start
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var localNotificationButton: UIButton!
    @IBOutlet weak var confirmOrderImageView: UIImageView!
    
    //MARK: IBOutlet end
    
    //MARK: Variables
    
    var location: String?
    var notificationcenter: UNUserNotificationCenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.backBarButtonItem?.tintColor = .white
        localNotificationButton.layer.cornerRadius = 10
        locationLabel.text = location
        
        //setting size of image
        confirmOrderImageView.frame = CGRect.zero
        confirmOrderImageView.center = CGPoint(x: 200, y: 250)
        
        notificationcenter = UNUserNotificationCenter.current()
        self.notificationcenter.delegate = self
        
        setAnimationForOrderView()
    }
    
    //MARK: Animation function
    
    //it will set animation for order logo image
    func setAnimationForOrderView() {
            UIView.animate(withDuration: 1, animations: {
                self.confirmOrderImageView.frame = CGRect(origin: CGPoint(x: 500, y: 500), size: CGSize(width: 100, height: 100))
                self.confirmOrderImageView.center = CGPoint(x: 200, y: 250)
                self.confirmOrderImageView.layer.masksToBounds = false
                self.confirmOrderImageView.layer.cornerRadius = self.confirmOrderImageView.frame.height/2
                self.confirmOrderImageView.clipsToBounds = true
            })
    }
    //MARK: IBAction
    
    @IBAction func confirmOrderButtonClicked(_ sender: Any) {
        //if product is present in cart then delete it from cart
        if productId != nil {
            DBManager.sharedDBMangerInstance().deleteProductFromCart(pID: productId!)
        }
        
        //create instance for class and calling its function to fire notification form Local Notification Framework
        let localNotification = LocalNotification()
        localNotification.fireLocalNotification(notificationmCenter: notificationcenter)
        
        //navigate to order placed view controller
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderPlacedViewController") as! OrderPlacedViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //MARK: Notification function
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
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

