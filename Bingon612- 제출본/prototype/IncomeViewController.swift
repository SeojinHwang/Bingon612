//
//  IncomeViewController.swift
//  prototype
//
//  Created by apple on 2017. 8. 14..
//  Copyright © 2017년 B612. All rights reserved.
//

import UIKit
import Realm
import RealmSwift



class IncomeViewController : UIViewController {
    
    @IBOutlet weak var IncomeField: UITextField!
    
    @IBAction func SaveIncome(_ sender: Any) {
        performSegue(withIdentifier: "unwindFromIncomeVC", sender: self)
    }
    
    @IBAction func CancelIncomeModal(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
