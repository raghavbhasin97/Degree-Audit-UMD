//
//  SaveTransition(TRY).swift
//  Audit
//
//  Created by Raghav Bhasin on 7/20/16.
//  Copyright © 2016 Firedust. All rights reserved.
//

import UIKit

class SaveTransition: NSObject, UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate,PiechartDelegate{

	static let animator = SaveTransition()

	
	
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 1.2
	}
	
	
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let container = transitionContext.containerView
		let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
		
		toView!.view.alpha = 0.0
		container.addSubview(toView!.view)
		/* 
		1)  Piechart slide from left
		2) update the view (exoand stuff)
		*/
		
		var views: [String: UIView] = [:]
		
		var currentCredits = Piechart.Slice()
		currentCredits.value = CGFloat(dataSet.numberOfCredits)
		currentCredits.color = Green
		currentCredits.text = "Satisfied"
		currentCredits.alpha = 0.8
		
		var totalCredits = Piechart.Slice()
		totalCredits.value = 120 - CGFloat(dataSet.numberOfCredits)
		totalCredits.color = Red
		totalCredits.text = "Unsatisfied"
		totalCredits.alpha = 0.8

		
		let piechart = Piechart()
		piechart.delegate = self
		piechart.title = "Credits"
		piechart.activeSlice = 0
		piechart.layer.borderWidth = 1
		piechart.slices = [currentCredits, totalCredits]
		
		piechart.translatesAutoresizingMaskIntoConstraints = false
		
		
		UIView.animate(withDuration: 0.2, animations: {
			container.addSubview(piechart)
			views["piechart"] = piechart
			container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[piechart(==339)]-|", options: [], metrics: nil, views: views))
			
			container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-150-[piechart(==200)]", options: [], metrics: nil, views: views))
				piechart.transform = CGAffineTransform(scaleX: 2, y: 2)
			
			}, completion: { (finished) in
				UIView.animate(withDuration: 1.2, animations: {
				 piechart.transform = CGAffineTransform(scaleX: 1,y: 1)
					toView!.view.alpha = 1.0
					}, completion: { (finished) in
						piechart.removeFromSuperview()
						transitionContext.completeTransition(true)
				})

		}) 
		
		
		
		}

	
	func setSubtitle(_ total: CGFloat, slice: Piechart.Slice) -> String {
		let percentage = NSString(format: "%.2f",(slice.value / total * 100))
		return "\(percentage)% \(slice.text)"
	}
	
	func setInfo(_ total: CGFloat, slice: Piechart.Slice) -> String {
		return "\(Int(slice.value))/\(Int(total))"
	}

}
