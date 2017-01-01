//
//  exPandAnimator.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/9/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit

class ExpandAnimator: NSObject, UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate  {
    
 static var animator = ExpandAnimator()
    
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
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        
        
        
        topView = fromView?.view.resizableSnapshotView(from: fromFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsMake(openingFrame!.origin.y,0,0,0))
        
        topView.frame = CGRect(x: 0,y: 0,width: fromFrame.width,height: openingFrame!.origin.y)
        
        TOPVIEW = topView
        container.addSubview(topView)
        
        
        bottomView = fromView!.view.resizableSnapshotView(from: fromFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsetsMake(0,0, fromFrame.height - openingFrame!.origin.y - openingFrame!.height,0))
        bottomView.frame = CGRect(x: 0,y: openingFrame!.origin.y + openingFrame!.height,width: fromFrame.width, height: fromFrame.height - openingFrame!.origin.y - openingFrame!.height)
        
        BOTTOMVIEW = bottomView
        container.addSubview(bottomView)
        
        let snapShotView = toView!.view.resizableSnapshotView(from: fromFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)
        snapShotView!.frame = openingFrame
        
        container.addSubview(snapShotView!)
        
        
        toView?.view.alpha = 0.0
        container.addSubview(toView!.view)
        
        
        UIView.animate(withDuration: 0.7, animations: {
            self.topView.frame = CGRect(x: 0,y: -self.topView.frame.height, width: self.topView.frame.width, height: self.topView.frame.height)
            self.bottomView.frame = CGRect(x: 0,y: fromFrame.height,width: self.bottomView.frame.width,height: self.bottomView.frame.height)
            snapShotView!.frame = toView!.view.frame
            }, completion: { (finished) in
            snapShotView!.removeFromSuperview()
                
                
                toView?.view.alpha = 1.0
                transitionContext.completeTransition(true)
        }) 
        
        
    }
    
}
