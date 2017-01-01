//
//  cellDetailAnimation.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/10/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit

class cellDetailAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    
    
    
    var top: UIView!
    var bottom: UIView!
    var table: UITableView!
    
    var chatView: CGRect!
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
     
        let container = transitionContext.containerView
        
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
       
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        let base = UIView(frame: CGRect(x: 0,y: 0,width: 1000,height: 100))
        base.backgroundColor = UIColor.white
        container.addSubview(base)
        top = fromView!.view.resizableSnapshotView(from: CGRect(x: self.chatView.origin.x,y: self.chatView.origin.y + 75,width: self.chatView.size.width,height: self.chatView.size.height-10), afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)
        
       
        top.frame = CGRect(x: self.chatView.origin.x,y: self.chatView.origin.y + 75,width: self.chatView.size.width,height: self.chatView.size.height-10)
       

       
        container.addSubview(top)
        
        bottom = toView!.view.resizableSnapshotView(from: CGRect(x: 0,y: 200,width: toView!.view.frame.width , height: toView!.view.frame.height), afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)
        self.bottom.frame = CGRect(x: 0,y: self.bottom.frame.height ,width: self.bottom.frame.width,height: self.bottom.frame.height)
        container.addSubview(bottom)
       
        
        let navView = toView!.view.resizableSnapshotView(from: CGRect(x: 0,y: 0,width: toView!.view.frame.size.width,height: 70), afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)
        navView!.frame = CGRect(x: 0,y: -toView!.view.frame.size.height,width: toView!.view.frame.size.width,height: 70)
        
        container.addSubview(navView!)
        toView!.view.alpha = 0
        container.addSubview((toView?.view)!)

        table.removeFromSuperview()
    
        
        chartVIEW = self.chatView
      
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.67, initialSpringVelocity: 0.4, options: UIViewAnimationOptions(), animations: {
            
            fromView!.view.alpha = 0
            self.top.frame = CGRect(x: 128,y: 87, width: self.top.frame.size.width, height: self.top.frame.size.height)
            self.bottom.frame = CGRect(x: 0,y: 200,width: self.bottom.frame.width,height: self.bottom.frame.height)
            navView!.frame = CGRect(x: 0,y: 0,width: toView!.view.frame.size.width,height: 70)
            }) {[unowned self] (finished) in
                base.removeFromSuperview()
                self.bottom.removeFromSuperview()
                self.top.removeFromSuperview()
                toView!.view.alpha = 1
                transitionContext.completeTransition(true)
        }
    }
    
    

}
