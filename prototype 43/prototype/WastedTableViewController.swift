//
//  WastedTableViewController.swift
//  prototype
//
//  Created by cscoi029 on 2017. 8. 17..
//  Copyright © 2017년 B612. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class WastedTableViewController: UITableViewController {
    
    var wasted:[Money] = []
  
    
    func getWastedObject() -> [Money] {
        let realm = try! Realm()
        let wobjects = realm.objects(Money.self).filter("iswastedmoney == true AND flag = 1")
        return Array<Money>(wobjects)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        wasted = getWastedObject()
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()



        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        let realm = try! Realm ()
//        let resultofExpense = realm.objects(Money.self)
//        let expensedata = resultofExpense.last!
//        return (expensedata.wastedindex)-1 //wasted만 되면!!!!!!
        return wasted.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        

        // Configure the cell...
        let expensearray = wasted[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        let cell : WastedWastedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Wasted", for: indexPath) as! WastedWastedTableViewCell
        if (expensearray.iswastedmoney == true) {
        cell.wawaDate.text = "\(formatter.string(from: expensearray.expensedate))"
        cell.wawaContent.text = "\(expensearray.expensereason)"
        cell.wawaPrice.text = "- "+"\(expensearray.expenseamount)"}
            return cell
    }


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
