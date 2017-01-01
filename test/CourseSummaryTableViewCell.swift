//
//  CourseSummaryTableViewCell.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/12/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit
import pop
class CourseSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var semester: UILabel!
    @IBOutlet weak var credit: UILabel!
	@IBOutlet weak var name: UILabel!
	
 
    @IBOutlet weak var frameLayer: UILabel!
    
    @IBOutlet weak var instructor: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(false, animated: false)
        
        


        // Configure the view for the selected state
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
        if(self.isHighlighted) {
            
            let scaleAnim = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            scaleAnim?.duration = 0.1
            scaleAnim?.toValue = NSValue(cgPoint: CGPoint(x: 0.95,y: 0.95))
            self.grade.pop_add(scaleAnim, forKey: "scaleAnimation")
            
            
            
        } else {
            let scaleAnim = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            
            scaleAnim?.toValue = NSValue(cgPoint: CGPoint(x: 1,y: 1))
            scaleAnim?.velocity = NSValue(cgPoint: CGPoint(x: 20,y: 20))
            scaleAnim?.springBounciness = 20.0
            self.grade.pop_add(scaleAnim, forKey: "scaleAnimation")
            
            
            
        }
    }

}
