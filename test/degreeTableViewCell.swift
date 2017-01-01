//
//  degreeTableViewCell.swift
//  Audit
//
//  Created by Raghav Bhasin on 6/24/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit

class degreeTableViewCell: UITableViewCell {

    @IBOutlet weak var classification: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var credits: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
