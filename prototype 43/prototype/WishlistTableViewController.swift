//
//  WishlistTableViewController.swift
//  prototype
//
//  Created by cscoi050 on 2017. 8. 9..
//  Copyright © 2017년 B612. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
//위시리스트 렘에 넣기


/*
 
 @IBOutlet weak var WishNameField: UITextField!
 
 @IBOutlet weak var WishField: UITextField!
 */

class Wish : Object {
    dynamic var name = ""
    dynamic var price = 0
    dynamic var buyableNumber = 0
}

struct TopLayout {
    var fixedLabel1, wastedLAbel, fixedLabel2: String
}


class WishlistTableViewController: UITableViewController {
    
    var arrayOfWish:[Wish] = []
    
    func getSomeObject() -> [Wish] {
        let realm = try! Realm()
        let objects = realm.objects(Wish.self)
        return Array<Wish>(objects)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        arrayOfWish = getSomeObject()
        self.tableView.reloadData() //추가된 정보를 받아 테이블뷰를 다시 리턴하는 함수
      //  super.viewWillAppear(animated)
       // self.tabBarController?.tabBar.tintColor = UIColor.black

        }

    

    
   
    
    @IBAction  func unwindFromWishModalVC (segue: UIStoryboardSegue) {
        let source = segue.source as? WIshModalViewController
        let newwish = Wish()
        let realm = try! Realm ()
        let result = realm.objects(Money.self)
        
        if (source?.WishField.text != nil && source?.WishNameField.text != nil){
            
            if (result.last != nil) {
                let usedata = result.last!
                newwish.price = Int((source?.WishField.text)!)!
                newwish.name = (source?.WishNameField.text)!
                newwish.buyableNumber = Int(usedata.wastedmoney / newwish.price)
            }
            else {
                newwish.price = Int((source?.WishField.text)!)!
                newwish.name = (source?.WishNameField.text)!
                newwish.buyableNumber = 0
            }
            
            do {
                try realm.write {
                    realm.add(newwish)
                }
            }
            catch let error {
                print("Error \(error)")
            }
            
        }
    }
    
    
    
    
    func addNewItem(newitem:[Wish]){
        let realm = try! Realm ()
        let newwish = realm.objects(Wish.self)
        var newitem = [newwish]
        
        newitem.append(newwish)
        
    }
    
    
    
    
    var  layoutData = [
        TopLayout(fixedLabel1: "낭비 금액", wastedLAbel: "40,000", fixedLabel2: "원 이면")
    ]
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) {
            return 1
        }
        else {
            let realm = try! Realm ()
            var countnumber = 0
            let wishes = realm.objects(Wish.self)
            countnumber = wishes.count
            return countnumber//data 몇개있는지 return
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        if indexPath.section == 0 {
            let cell : WIshTopLayoutCell = tableView.dequeueReusableCell(withIdentifier: "TopLayoutCell", for: indexPath) as! WIshTopLayoutCell
            let layoutItem = layoutData[indexPath.row]
            let realm = try! Realm ()
            let waste = realm.objects(Money.self)
            let wastedamou = waste.last!
            cell.fixedLabel1.text = layoutItem.fixedLabel1
            cell.wastedLAbel.text = "\(wastedamou.wastedmoney)"
            cell.fixedLabel2.text =  layoutItem.fixedLabel2
            
            return cell
        }
        else {
            let cell : WishTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WishCell-1", for: indexPath) as! WishTableViewCell
            let item = arrayOfWish[indexPath.row]
            
            cell.number.text = "\(Int(arrayOfWish.index(of:item)! + 1))"
            cell.name.text = item.name
            cell.price.text = "\(item.price) 원"
            cell.buyableNumber.text = "\(item.buyableNumber) 개"
            
            return cell
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let itemRoom = [Wish()]
        
        if segue.identifier == "unwindFromWishModalVC" {
            
            
            let wishlistVC = segue.destination as? WishlistTableViewController
            
            return wishlistVC!.addNewItem(newitem: itemRoom)
        } else {
            return
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 100
        }
        else {
            return 60
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
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
