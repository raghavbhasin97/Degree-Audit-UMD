//
//  GPACoursesTableViewCell.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/15/16.
//  Copyright © 2016 Firedust. All rights reserved.
//

import UIKit

class GPACoursesTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var GPA: UILabel!
    @IBOutlet weak var QP: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
