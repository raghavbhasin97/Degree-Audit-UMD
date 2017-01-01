//
//  popover.swift
//  Audit
//
//  Created by Raghav Bhasin on 6/23/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit
import Darwin

class popover: UIViewController {
    
     var background :UIImage = UIImage()
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name : UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.image = self.ResizeImage((User.photo)!, targetSize: CGSize(width: 400*factor, height: 380))
        name.text =  User.FirstName + " " + User.lastName
        profilePic.layer.cornerRadius = 8.0
        profilePic.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
 
    @IBAction func exitFunc() {
        exit(0)
    }
    
    
    
    func ResizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
