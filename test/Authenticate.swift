//
//  Authenticate.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/10/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit



class Authenticate: UIViewController,UIViewControllerTransitioningDelegate {
    

     
    override func viewDidLoad() {
        super.viewDidLoad()
        
     splash()
 
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
 
    func splash() {
        
        let seconds = 0.0
        let delay = seconds * Double(NSEC_PER_SEC)
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
			
            self.go()
        }
        
           
    }

   
    func go() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let vc : UITabBarController = storyBoard.instantiateViewController(withIdentifier: "mainWindow") as! UITabBarController
        
        vc.transitioningDelegate  = self
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }

    
    
  


    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
       let transition = splashTransition.animator
        return transition
    }
 
    
    }




