//
//  WIshModalViewController.swift
//  
//
//  Created by cscoi028 on 2017. 8. 16..
//
//

import UIKit
import Realm
import RealmSwift


class WIshModalViewController: UIViewController {

    @IBOutlet weak var WishNameField: UITextField!
    
    @IBOutlet weak var WishField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading /Users/cscoi028/Downloads/prototype 17 +data from whole and income/prototype/ViewController.swiftthe view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SaveWish(_ sender: Any) {
        performSegue(withIdentifier: "unwindFromWishModalVC", sender: self)
    }
    
    
    @IBAction func CancelWish(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
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
