//
//  LocalNotification.swift
//  LocalNotificationFramework
//
//  Created by Capgemini-DA204 on 9/25/22.
//


import Foundation
import UserNotifications
import UIKit

public class LocalNotification {
    public init() {
        
    }
    
    public func fireLocalNotification(notificationmCenter: UNUserNotificationCenter) {
        let content = UNMutableNotificationContent()
        content.title = "Your order will deliver shortly"
        content.badge = NSNumber(value: 1)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)
        
        notificationmCenter.add(request) {
            (error) in
            if let error = error {
                print("Error Occured: ", error)
            }
        }
        
    }
}
