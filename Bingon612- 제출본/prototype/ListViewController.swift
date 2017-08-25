//
//  ListViewController.swift
//  prototype
//
//  Created by cscoi029 on 2017. 8. 17..
//  Copyright © 2017년 B612. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ListViewController: UIViewController {

    @IBOutlet weak var leftMoney: UILabel!
    @IBOutlet weak var leftDays: UILabel!
    @IBOutlet weak var listOfAll: UIView!
    @IBOutlet weak var listOfWasted: UIView!
    
    @IBAction func segmented(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            listOfAll.isHidden = false
            listOfWasted.isHidden = true
        case 1:
            listOfAll.isHidden = true
            listOfWasted.isHidden = false
        default:
            break;
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let realm = try! Realm ()
        let resultofExpense = realm.objects(Money.self)
        let data = resultofExpense.last!
        
        leftMoney.text = "\(data.wholemoney)원"
        leftDays.text = "남은 일수 7일"
       // super.viewWillAppear(animated)
       // self.tabBarController?.tabBar.tintColor = UIColor.black


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
