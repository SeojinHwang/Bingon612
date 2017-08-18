//
//  WholeMoneyViewController.swift
//  prototype
//
//  Created by apple on 2017. 8. 14..
//  Copyright © 2017년 B612. All rights reserved.
//

import UIKit
import Realm
import RealmSwift


class WholeMoneyViewController: UIViewController {
    
    @IBOutlet weak var WholeMoneyField: UITextField!
    @IBOutlet weak var WholeDateField: UITextField!
    
    @IBAction func SaveWhole(_ sender: Any) {
        performSegue(withIdentifier: "unwindFromWholeVC", sender: self)
    }
    
    @IBAction func CancelWholeModal(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
