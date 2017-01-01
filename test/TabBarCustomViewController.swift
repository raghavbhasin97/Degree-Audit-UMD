//
//  TabBarCustomViewController.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/12/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit

class TabBarCustomViewController:  BFPaperTabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUptheView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func setUptheView() {
        
        self.tabBar.tintColor = UIColor(netHex: 0x651FFF)
        
        self.delegate = self;
        self.rippleFromTapLocation = true
        self.tapCircleDiameter = 200.0
        self.tapCircleColor = UIColor(netHex: 0x651FFF)
        
        self.underlineColor = UIColor(netHex: 0x651FFF)
        self.animateUnderlineBar = true
        
    
    }
}
