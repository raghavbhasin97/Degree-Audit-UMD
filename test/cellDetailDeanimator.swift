//
//  cellDetailDeanimator.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/11/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit

class cellDetailDeanimator: NSObject, UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate  {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    var openingView: CGRect!
    
    
    var chatView:CGRect!
    var top: UIView!
    var bottom: UIView!
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        chatView = chartVIEW
        let container = transitionContext.containerView
        
               let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let base = UIView(frame: CGRect(x: 0,y: 0,width: 1000,height: 100))
        base.backgroundColor = UIColor.white
        container.addSubview(base)
     
        bottom = fromView!.view.resizableSnapshotView(from: CGRect(x: 0,y: 200,width: toView!.view.frame.width , height: toView!.view.frame.height), afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)
        self.bottom.frame = CGRect(x: 0,y: 200,width: self.bottom.frame.width,height: self.bottom.frame.height)
  
        container.addSubview(bottom)
        
        
        
        let navView = fromView!.view.resizableSnapshotView(from: CGRect(x: 0,y: 20,width: toView!.view.frame.size.width,height: 50), afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)
        
        navView!.frame = CGRect(x: 0,y: 20,width: toView!.view.frame.size.width,height: 50)
        container.addSubview(navView!)
        
        
        top = fromView!.view.resizableSnapshotView(from: CGRect(x: 128,y: 87,width: chatView.size.width, height: chatView.size.height), afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)
        
        top.frame = CGRect(x: 128,y: 87,width: chatView.size.width, height: chatView.size.height)
        
        container.addSubview(top)
        toView!.view.alpha = 0
        container.addSubview((toView?.view)!)
        

        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.67, initialSpringVelocity: 0.4, options: UIViewAnimationOptions(), animations: {
            
            self.top.frame = CGRect(x: self.chatView.origin.x,y: self.chatView.origin.y + 75,width: self.chatView.size.width,height: self.chatView.size.height-10)

             self.bottom.frame = CGRect(x: 0,y: self.bottom.frame.height - 50 ,width: self.bottom.frame.width,height: self.bottom.frame.height)
            navView!.frame = CGRect(x: 0,y: -100,width: toView!.view.frame.size.width,height: 50)
            toView!.view.alpha = 1

        }) { [unowned self] (finished) in
            fromView!.view.alpha = 0
            base.removeFromSuperview()
            navView!.removeFromSuperview()
            self.bottom.removeFromSuperview()
            self.top.removeFromSuperview()
           
            transitionContext.completeTransition(true)
        }
        
        
    }



    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    

}
