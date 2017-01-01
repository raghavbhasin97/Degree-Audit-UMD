//
//  Extension.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/10/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//




//MARK: UIColor Hex initializer extension

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}





let Green = UIColor(red: 77.0/255.0, green: 186.0/255.0, blue: 122.0/255.0, alpha: 2.0)
let Red = UIColor(red: 245.0/255.0, green: 94.0/255.0, blue: 78.0/255.0, alpha: 2.0)

let blue = UIColor(red: 50/255, green: 79/255, blue: 133/255, alpha: 1.0)