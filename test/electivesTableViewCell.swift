//
//  electivesTableViewCell.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/2/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit

class electivesTableViewCell: UITableViewCell {

    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var credit1: UILabel!
    @IBOutlet weak var grade1: UILabel!
    @IBOutlet weak var desc1: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var credit2: UILabel!
    @IBOutlet weak var grade2: UILabel!
    @IBOutlet weak var desc2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
