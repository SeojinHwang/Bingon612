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

class IncomeMoney : Object {
    dynamic var incomeamount = 0
}
class ExpenseMoney : Object {
    dynamic var expenseamount = 0
    dynamic var expensedate = Date()
    dynamic var expensereason = ""
    dynamic var iswastedmoney = false
}
class WastedMoney : Object {
    dynamic var wastedmoney = 0
}
class WholeMoney : Object {
    dynamic var wholemoney = 0
    dynamic var wholedays = 0
}
class TodayMoney : Object {
    dynamic var today = 0
    dynamic var todaymoney = 0
    dynamic var todayusingmoney = 0
    dynamic var todayrate = 0
}

class Money : Object {
    let I = List<IncomeMoney>()
    let E = List<ExpenseMoney>()
    let W = List<WholeMoney>()
    let T = List<TodayMoney>()
}


class ViewController: UIViewController {

    @IBOutlet weak var WholeMoneyPrintField: UILabel!
    @IBOutlet weak var WholeDaysPrintField: UILabel!
    @IBOutlet weak var TodayPrintField: UILabel!
    @IBOutlet weak var TodayMoneyPrintField: UILabel!
    @IBOutlet weak var FlowerImage: UIImageView!
    @IBOutlet weak var StarImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let realm = try! Realm ()
        let resultofTodayData = realm.objects(TodayMoney.self)
        let resultofWholeData = realm.objects(WholeMoney.self)
        let resultofWish = realm.objects(Wish.self)
        
        if (resultofTodayData.last != nil) { //전체 nil인지 아닌지
                let data = resultofTodayData.last!
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
                TodayPrintField.text = "\(data.today)"
                TodayMoneyPrintField.text = "\(data.todayusingmoney)"
            }
        else {//today is nil
            FlowerImage.image = UIImage(named: "100.png")
            TodayPrintField.text = "0"
            TodayMoneyPrintField.text = "0"
        }
        
        if (resultofWholeData.last != nil) {//Whole isn't nill
            let data = resultofWholeData.last!
            WholeDaysPrintField.text = "\(data.wholedays)"
            WholeMoneyPrintField.text = "\(data.wholemoney)"
        }
        else {//Whole is nill
            WholeDaysPrintField.text = "0"
            WholeMoneyPrintField.text = "0"
        }
        
        if (resultofWish.last != nil) {
            var num = 0
            num = resultofWish.count
            switch num {
                case 5  :
                    StarImage.image = UIImage(named: "5stars.png")
                case 4 :
                    StarImage.image = UIImage(named: "4stars.png")
                case 3 :
                    StarImage.image = UIImage(named: "3stars.png")
                case 2 :
                    StarImage.image = UIImage(named: "2stars.png")
                case 1 :
                    StarImage.image = UIImage(named: "1stars.png")
                default :
                    if (num > 5){
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
    }

    @IBAction func unwindFromIncomeVC(segue: UIStoryboardSegue){
        let source = segue.source as? IncomeViewController
        let realm = try! Realm ()
        let incomedata = IncomeMoney ()
        let getWholedata = realm.objects(WholeMoney.self)
        let wholedata = WholeMoney (value: getWholedata.last!)
        let getTodaydata = realm.objects(TodayMoney.self)
        let todaydata = TodayMoney (value: getTodaydata.last!)
        if (source?.IncomeField.text != nil){
            try! realm.write {
                incomedata.incomeamount = Int((source?.IncomeField.text)!)!
                wholedata.wholemoney += incomedata.incomeamount
                todaydata.todayusingmoney += incomedata.incomeamount
                todaydata.todayrate = Int((todaydata.todayusingmoney)*100 / todaydata.todaymoney)
                realm.add(incomedata)
                realm.add(wholedata)
                realm.add(todaydata)
            }
        }
    }
    
    @IBAction func unwindFromExpenseVC(segue: UIStoryboardSegue){
        let source = segue.source as? ExpenseViewController
        let realm = try! Realm ()
        let expensedata = ExpenseMoney ()
        let getWholedata = realm.objects(WholeMoney.self)
        let wholedata = WholeMoney (value: getWholedata.last!)
        let getTodaydata = realm.objects(TodayMoney.self)
        let todaydata = TodayMoney (value: getTodaydata.last!)
        try! realm.write {
            if (source?.ExpenseField.text != nil) {
                expensedata.expenseamount = Int((source?.ExpenseField.text)!)!
                expensedata.expensereason = (source?.ExpenseReasonField.text)!
                expensedata.expensedate = (source?.ExpenseDate.date)!
                if (source?.IsWasteMoney.isOn)! {
                    expensedata.iswastedmoney = true
                    let getWastedData = realm.objects(WastedMoney.self)
                    if (getWastedData.last != nil) {
                        let wastedata = WastedMoney (value: getWastedData.last!)
                        wastedata.wastedmoney += expensedata.expenseamount
                        realm.add(wastedata)
                    }
                    else {
                        let newwastedata = WastedMoney()
                        newwastedata.wastedmoney += expensedata.expenseamount
                        realm.add(newwastedata)
                    }
                }
                else {
                    expensedata.iswastedmoney = false
                }
                realm.add(expensedata) //expense, wasted 총량 저장하고 이제 today랑 whole계산
                wholedata.wholemoney -= expensedata.expenseamount
                todaydata.todayusingmoney -= expensedata.expenseamount
                todaydata.todayrate = Int((todaydata.todayusingmoney)*100 / todaydata.todaymoney)
                realm.add(wholedata)
                realm.add(todaydata)
            }
        }
        /*
            WholeMoneyPrintField.text = "\(exMoney.wholemoney)"
            WholeDaysPrintField.text = "\(exMoney.wholedays)"
            TodayMoneyPrintField.text = "\(exMoney.todayusingmoney)"
        }*/
        
    }
    

    @IBAction func unwindFromWholeVC(segue: UIStoryboardSegue){
        let source = segue.source as? WholeMoneyViewController
        let realm = try! Realm ()
        let wholedata = WholeMoney()
        if (source?.WholeMoneyField.text != nil && source?.WholeDateField.text != nil){
            wholedata.wholemoney = Int((source?.WholeMoneyField.text)!)!
            wholedata.wholedays = Int((source?.WholeDateField.text)!)!
            let todaydata = TodayMoney()
            todaydata.todaymoney = Int(wholedata.wholemoney / wholedata.wholedays)
            todaydata.todayusingmoney = todaydata.todaymoney
            todaydata.todayrate = 100
            todaydata.today = 1
            try! realm.write {
                realm.add(wholedata)
                realm.add(todaydata)
            }
            print(todaydata.todaymoney)
            print(todaydata.todayusingmoney)
            print(wholedata.wholemoney)
        }
    }
    
    @IBAction func unwindFromInitiateVC(segue: UIStoryboardSegue){
        
    }

}


extension ViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
}



