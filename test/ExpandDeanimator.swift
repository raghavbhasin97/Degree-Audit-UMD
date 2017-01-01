//
//  ExpandDeanimator.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/9/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit

class ExpandDeanimator: NSObject, UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate  {
    static var animator = ExpandDeanimator()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    var openingFrame: CGRect!
    var  topView: UIView!
    var bottomView: UIView!
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let fromFrame = fromView!.view.frame
        let fromFrame2 = CGRect(x: fromFrame.origin.x, y: fromFrame.origin.y, width: fromFrame.width, height: fromFrame.height - openingFrame.height)
        
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        bottomView = BOTTOMVIEW
  
        
         topView = toView?.view.resizableSnapshotView(from: fromFrame2, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsMake(openingFrame!.origin.y,0,0,0))
        
        topView.frame = CGRect(x: 0,y: -self.topView.frame.height,width: self.topView.frame.width,height: self.topView.frame.height)
      
      
        container.addSubview(topView)
        
        container.addSubview(bottomView)
        
        let snapShotView = fromView!.view.resizableSnapshotView(from: fromFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)
        
        snapShotView!.frame = fromView!.view.frame
        
        container.addSubview(snapShotView!)
      
        
        
        toView?.view.alpha = 0.0
        container.addSubview(toView!.view)
        UIView.animate(withDuration: 0.7, animations: {
            self.topView.frame = CGRect(x: 0,y: 0,width: self.topView.frame.width,height: self.topView.frame.height)
            
            self.bottomView.frame = CGRect(x: 0,y: self.openingFrame!.origin.y + self.openingFrame!.height,width: fromFrame.width, height: fromFrame.height - self.openingFrame!.origin.y - self.openingFrame!.height)
          
            snapShotView!.frame = self.openingFrame
            
            
        }, completion: { (finished) in
            snapShotView!.removeFromSuperview()
            
            
            toView?.view.alpha = 1.0
            transitionContext.completeTransition(true)
        }) 
        
        
    }
    
    
    
}

