//
//  splashTransition.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/19/16.
//  Copyright © 2016 Firedust. All rights reserved.
//

import UIKit

class splashTransition: NSObject, UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate, SKSplashDelegate  {

  static let animator = splashTransition()
    let offsetX:CGFloat = 0.0
    let offsetY:CGFloat = 0.0
    
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.8
    }
    
  
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        setStatusBarBackgroundColor(UIColor(netHex: 0xA00907))
     
       
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        
        container.addSubview(toView!.view)
        let backView = UIView(frame: toView!.view.frame)
       backView.backgroundColor = UIColor(netHex: 0xA00907)
          container.addSubview(backView)
        let splashIcon: SKSplashIcon = SKSplashIcon(image: UIImage(named: "logo-White"), animationType: .bounce)
        
        splashIcon.backgroundColor = UIColor(netHex: 0xA00907)
        let splashView: SKSplashView = SKSplashView(splashIcon: splashIcon, animationType: .none)
        splashView.animationDuration = 3.0
        splashView.delegate = self
        container.addSubview(splashView)
        splashView.startAnimation()


       
        let seconds = 2.1
        let delay = seconds * Double(NSEC_PER_SEC)
        let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            backView.removeFromSuperview()

             UIView.animate(withDuration: 0.1, animations: {

                self.setStatusBarBackgroundColor(UIColor(netHex: 0xF8F8F8))
            }, completion: { (finished) in
              

                splashView.removeFromSuperview()
                transitionContext.completeTransition(true)
            }) 
    
        })
      
        

    }
    
    
    func setStatusBarBackgroundColor(_ color: UIColor)
    {
        guard  let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as AnyObject).value(forKey: "statusBar") as? UIView
            else
        {
            return
        }
        statusBar.backgroundColor = color
    }

    

}


