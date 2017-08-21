//
//  TabbatitemViewController.swift
//  prototype
//
//  Created by cscoi028 on 2017. 8. 21..
//  Copyright © 2017년 B612. All rights reserved.
//

import UIKit

class TabbatitemViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.tabBar.unselectedItemTintColor = UIColor.black

        // Do any additional setup after loading the view.
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
/*
extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 34) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 35) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 61) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}*/
