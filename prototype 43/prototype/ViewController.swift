//
//  ViewController.swift
//  prototype
//
//  Created by cscoi027 on 2017. 8. 2..
//  Copyright © 2017년 B612. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import UserNotifications

class Money : Object {
    dynamic var incomeamount = 0 //for income
    dynamic var expenseamount = 0
    dynamic var expensedate = Date()
    dynamic var expensereason = ""
    dynamic var iswastedmoney = false
    dynamic var wastedmoney = 0
    dynamic var wastedindex = 0 //for expense
    dynamic var wholemoney = 0
    dynamic var wholedays = 0
    dynamic var todaymoney = 0 // for whole, do not change
    dynamic var todayusingmoney = 0
    dynamic var todayrate = 0
    dynamic var flag = 0
}

//필요한 구조체 선언



class ViewController: UIViewController {

    @IBOutlet weak var WholeMoneyPrintField: UILabel!
   
    @IBOutlet weak var WholeDaysPrintField: UILabel!
   
    @IBOutlet weak var TodayMoneyPrintField: UILabel!
    
    @IBOutlet weak var FlowerImage: UIImageView!
    
    @IBOutlet weak var StarImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)// Do any additional setup after loading the view, typically from a nib.
        //self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for:.)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let realm = try! Realm ()
        let resultofData = realm.objects(Money.self)
        let resultofWish = realm.objects(Wish.self)
        
        if (resultofData.last != nil) {
            let data = resultofData.last!
            switch data.todayrate {
            case 76 ... 100  :
                FlowerImage.image = UIImage(named: "100.png")
            case 51 ... 75 :
                FlowerImage.image = UIImage(named: "75.png")
            case 26 ... 50 :
                FlowerImage.image = UIImage(named: "50.png")
            case 1 ... 25 :
                FlowerImage.image = UIImage(named: "25.png")
            default :
                if (data.todayrate > 100){
                    FlowerImage.image = UIImage(named: "100.png")
                }
                else {
                    FlowerImage.image = UIImage(named: "0.png")
                }
            }
            WholeMoneyPrintField.text = "\(data.wholemoney)"
            WholeDaysPrintField.text = "\(data.wholedays)"
            TodayMoneyPrintField.text = "\(data.todayusingmoney)"
        }
        else {
            FlowerImage.image = UIImage(named: "100.png")
        }
        if (resultofWish.last != nil) {
            var countnumber = 0
            countnumber = resultofWish.count
            switch countnumber {
            case 5  :
                StarImage.image = UIImage(named: "5stars.png")
            case 4 :
                StarImage.image = UIImage(named: "4stars.png")
            case 3 :
                StarImage.image = UIImage(named: "3stars.png")
            case 2 :
                StarImage.image = UIImage(named: "2star.png")
            case 1 :
                StarImage.image = UIImage(named: "1stars.png")
            default :
                if (countnumber > 5){
                    StarImage.image = UIImage(named: "5stars.png")
                }
                else {
                    StarImage.image = UIImage(named: "0stars.png")
                }
            }
        }
        else {
            StarImage.image = UIImage(named: "0stars.png")
        }
        
        //super.viewWillAppear(animated)
        //self.tabBarController?.tabBar.tintColor = UIColor.black
    }

    @IBAction func unwindFromIncomeVC(segue: UIStoryboardSegue){
        let source = segue.source as? IncomeViewController
        let realm = try! Realm ()
        let resultofWM = realm.objects(Money.self)
        let inMoney = Money (value: resultofWM.last!)
        if (source?.IncomeField.text != nil){
            try! realm.write {
                inMoney.incomeamount = Int((source?.IncomeField.text)!)!
                inMoney.wholemoney += inMoney.incomeamount
                inMoney.todayusingmoney = inMoney.todayusingmoney + inMoney.incomeamount
                inMoney.todayrate = Int((inMoney.todayusingmoney)*100 / inMoney.todaymoney)
                inMoney.flag = 0
                realm.add(inMoney)
            }
            WholeMoneyPrintField.text = "\(inMoney.wholemoney)"
            WholeDaysPrintField.text = "\(inMoney.wholedays)"
            TodayMoneyPrintField.text = "\(inMoney.todayusingmoney)"
        
        }
    }
    @IBAction func unwindFromExpenseVC(segue: UIStoryboardSegue){
        let source = segue.source as? ExpenseViewController
        let realm = try! Realm ()
        let resultofCM = realm.objects(Money.self)
        let exMoney = Money (value: resultofCM.last!)
        if (source?.ExpenseField.text != nil) {
            try! realm.write {
                exMoney.expenseamount = Int((source?.ExpenseField.text)!)!
                exMoney.expensereason = (source?.ExpenseReasonField.text)!
                exMoney.expensedate = (source?.ExpenseDate.date)!
                if (source?.IsWasteMoney.isOn)! {
                    exMoney.iswastedmoney = true
                    exMoney.wastedmoney += exMoney.expenseamount
                    exMoney.wastedindex += 1
                } else {
                    exMoney.iswastedmoney = false
                }
                //exMoney.todayrate = Int((exMoney.todaymoney - exMoney.expenseamount / exMoney.todaymoney)*100)
                exMoney.todayusingmoney = exMoney.todayusingmoney - exMoney.expenseamount
                exMoney.todayrate = Int((exMoney.todayusingmoney)*100 / exMoney.todaymoney)
                exMoney.wholemoney -= exMoney.expenseamount
                exMoney.flag = 1
                realm.add(exMoney)
            }
            WholeMoneyPrintField.text = "\(exMoney.wholemoney)"
            WholeDaysPrintField.text = "\(exMoney.wholedays)"
            TodayMoneyPrintField.text = "\(exMoney.todayusingmoney)"
        }
        
    }
    

    @IBAction func unwindFromWholeVC(segue: UIStoryboardSegue){
        let source = segue.source as? WholeMoneyViewController
        let wholeMoney = Money()
        if (source?.WholeMoneyField.text != nil && source?.WholeDateField.text != nil){
            wholeMoney.wholemoney = Int((source?.WholeMoneyField.text)!)!
            wholeMoney.wholedays = Int((source?.WholeDateField.text)!)!
              wholeMoney.todaymoney = Int(wholeMoney.wholemoney / wholeMoney.wholedays)
            wholeMoney.todayusingmoney = wholeMoney.todaymoney
            wholeMoney.todayrate = 100
            wholeMoney.flag = 0
            let realm = try! Realm ()
            try! realm.write {
                realm.add(wholeMoney)
                }
        WholeMoneyPrintField.text = "\(wholeMoney.wholemoney)"
        WholeDaysPrintField.text = "\(wholeMoney.wholedays)"
        TodayMoneyPrintField.text = "\(wholeMoney.todaymoney)"
        }
        //error return 추가
    }
    
    @IBAction func unwindFromInitiateVC(segue: UIStoryboardSegue){
        let realm = try! Realm ()
        let resultofCM = realm.objects(Money.self)
        let lastdata = Money (value: resultofCM.last!)
        try! realm.write {
            
        lastdata.flag = 0
        lastdata.todayrate = 100
        lastdata.todaymoney = 0
        lastdata.todayusingmoney = 0
        lastdata.wholedays = 0
        lastdata.wholemoney = 0
        realm.add(lastdata)
        }
        
    }
    

    

    
    
    
    
}


extension ViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
}



