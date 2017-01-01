//
//  programTableViewCell.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/7/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit
import pop

class programTableViewCell: UITableViewCell {

    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var Gpa: UILabel!

    
    var index:IndexPath!
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
  
    }

}
