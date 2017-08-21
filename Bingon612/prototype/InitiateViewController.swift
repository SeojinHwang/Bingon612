//
//  InitiateViewController.swift
//  prototype
//
//  Created by apple on 2017. 8. 14..
//  Copyright © 2017년 B612. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class InitiateViewController: UIViewController {
    
    @IBAction func Initiate(_ sender: Any) {
        
        performSegue(withIdentifier: "unwindFromInitiateVC", sender: self)
        

    }
    
    
    @IBAction func CancelInitiateModal(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
