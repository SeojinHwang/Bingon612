//
//  SettingTableViewController.swift
//  prototype
//
//  Created by cscoi024 on 2017. 8. 8..
//  Copyright © 2017년 B612. All rights reserved.
//

import UIKit
import UserNotifications
import RealmSwift
import Realm


class SettingTableViewController: UITableViewController {
    
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            
            completionHandler(success)
        }
    }
    
    
    @IBOutlet weak var AlarmTime: UIDatePicker!
    
    private func scheduleLocalNotification() {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        let realm = try! Realm ()
        let getdataresult = realm.objects(TodayMoney.self)
        if (getdataresult.last != nil) {
            let recentdata = getdataresult.last!
            // Configure Notification Content
            notificationContent.title = ""
            notificationContent.body = "오늘 쓸 수 있는 돈은 " + "\(recentdata.todaymoney)" + "원입니다."
        }
        else {
            // Configure Notification Content
            notificationContent.title = ""
            notificationContent.body = "금액과 생존 일수를 입력해주세요."}

        
        // Add Trigger
        // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: AlarmTime.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        // Create Notification Request
        //        let notificationRequest = UNNotificationRequest(identifier: "BINGON612_request", content: notificationContent, trigger: notificationTrigger)
        let notificationRequest = UNNotificationRequest(identifier: "BINGON612_request", content: notificationContent, trigger: trigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
            else {
                print("add success")
            }
        }
    }
    
    

    @IBOutlet weak var AlarmSwitch: UISwitch!
    @IBAction func NotifSwitch(_ sender: Any) {
           if AlarmSwitch.isOn {
            UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
                switch notificationSettings.authorizationStatus {
                case .notDetermined:
                    // Request Authorization
                    self.requestAuthorization(completionHandler: { (success) in
                        guard success else { return }})
                case .authorized:
                    // Schedule Local Notification
                    self.scheduleLocalNotification()
                case .denied:
                    print("Application Not Allowed to Display Notifications")
                }
            }
        }
        else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.tintColor = UIColor.black

    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        // #warning Incomplete implementation, return the number of rows
    //        return 0
    //    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
