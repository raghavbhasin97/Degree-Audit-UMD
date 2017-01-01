//
//  slideTransition.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/8/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit

class slideTransition: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    //Enum to tell wheather the transition is load or back
    enum transtionStyle :Int {
        case slideRight // Go Back
        ,slideLeft // Load Item
    }
    
    var slideLeftDuration = 0.8
    var slideRightDuration = 0.5
   
    var multiplier: CGFloat
    var damping: CGFloat
    init(style: transtionStyle) {
    
        self.multiplier = (style == .slideLeft) ? -1.0 : 1.0
        self.damping = (style == .slideLeft) ? 0.45 : 0.55
    }
    
    var transitionStyle: transtionStyle = .slideLeft
    
     func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return (transitionStyle == .slideLeft) ? slideLeftDuration : slideRightDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        let startPoint = CGAffineTransform(translationX: -(container.frame.width)*multiplier, y: 0)
        let endPoint = CGAffineTransform(translationX: (container.frame.width)*multiplier, y: 0)
        
        toView?.transform = startPoint
        container.addSubview(toView!)
        
        let duration = self.transitionDuration(using: transitionContext)
        
       
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: self.damping, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: {
            
            fromView?.transform = endPoint
            toView?.transform = CGAffineTransform.identity
            
            }, completion: { finished in
			
            transitionContext.completeTransition(true)
                
        })
    }
  
   

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
  
}
