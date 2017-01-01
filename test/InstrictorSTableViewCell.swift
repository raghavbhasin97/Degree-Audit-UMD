//
//  InstrictorSTableViewCell.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/16/16.
//  Copyright © 2016 Firedust. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class InstrictorSTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leafImage: UIImageView!
    @IBOutlet weak var title: UILabel!
   
    var data: [String]! = []
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        tableView.delegate = self
        tableView.dataSource = self
        extractSet()
        
        if(data.count == 0) {
            tableView.emptyDataSetSource = self
            tableView.emptyDataSetDelegate = self
            tableView.tableFooterView = UIView()
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "c2")
        cell.textLabel!.text = data[indexPath.row]
        cell.textLabel!.font = UIFont.systemFont(ofSize: 13.0)
        return cell
    }
    
    
    func extractSet() {
        for course in dataSet.courses {
            if(course.term == "SPRING") {
                data.append("\(course.instructorName) for \(course.name)")
            }
        }
    }
    
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let text:NSString = "No SPRING Courses"
        
        
        let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 22.0)]
        return NSAttributedString(string: text as String, attributes: attributes)
        
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let text:NSString = "No Courses have been taken in the SPRING Semester so far."
        
        
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
        return NSAttributedString(string: text as String, attributes: attributes)
    }
    
    

}
