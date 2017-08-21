//
//  NotificationDelegate.swift
//  prototype
//
//  Created by cscoi026 on 2017. 8. 16..
//  Copyright © 2017년 B612. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationDelegate: UIViewController, UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure User Notification Center
        UNUserNotificationCenter.current().delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
