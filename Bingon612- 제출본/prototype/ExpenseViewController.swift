//
//  ExpenseViewController.swift
//  prototype
//
//  Created by apple on 2017. 8. 14..
//  Copyright © 2017년 B612. All rights reserved.
//

import UIKit
import Realm
import RealmSwift


class ExpenseViewController : UIViewController {
    
    @IBOutlet weak var ExpenseReasonField: UITextField!
    
    @IBOutlet weak var ExpenseField: UITextField!
    
    @IBOutlet weak var IsWasteMoney: UISwitch!
    
    @IBOutlet weak var ExpenseDate: UIDatePicker!
    
    @IBAction func SaveExpense(_ sender: Any) {
           performSegue(withIdentifier: "unwindFromExpenseVC", sender: self)
    }
    
    
    @IBAction func CancelExpenseModal(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
