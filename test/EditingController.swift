//
//  editCoursesController.swift
//  Audit
//
//  Created by Raghav Bhasin on 6/17/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit
import pop
import DZNEmptyDataSet



class EditingController : UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
     var openingFrame: CGRect!
    let transition = slideTransition(style: .slideRight)

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var tableView: UITableView!

    var StyeleEdit = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if(dataSet.courses.count == 0) {
            navBar.rightBarButtonItem?.isEnabled = false
        }

	       tableView.contentOffset.y = offset_table
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        navBar.rightBarButtonItem?.tintColor = UIColor.black
        navigationBar.titleTextAttributes
            = [NSForegroundColorAttributeName: UIColor(netHex:0x0A60FE),
                                             NSFontAttributeName: UIFont(name: "ChalkboardSE-Bold", size: 19.0)!]
        configureEmptyView()
        
        
    }
    
    func configureEmptyView() {
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        
        
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataSet.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let identifier = "courseSummary"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CourseSummaryTableViewCell
        let course = dataSet.courses[indexPath.row]
        cell.name.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        cell.grade.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        cell.grade.textColor = UIColor.red
        cell.semester.font = UIFont(name: "HelveticaNeue-Medium", size: 11.3)
        cell.credit.font = UIFont(name: "HelveticaNeue-Medium", size: 11.3)
        cell.instructor.font = UIFont(name: "HelveticaNeue-Medium", size: 11.3)
        cell.instructor.textColor = UIColor(netHex: 0x502075)
        
        
        cell.grade.text = course.gradeEarned
        cell.name.text = course.name
        if(course.term == "AP") {
              cell.semester.text = "Advanced Placement"
              cell.instructor.text = "Transfer Credits"
               cell.grade.text = "Transfer"
            cell.grade.font = UIFont(name: "HelveticaNeue-Light", size: 13.2)
        } else {
              cell.semester.text = course.term
              cell.instructor.text = course.instructorName
        }
    
        cell.semester.textColor = UIColor(netHex: 0x502075)
        cell.credit.textColor = UIColor(netHex: 0x502075)
        cell.credit.text = String(NSString(format: "%0.2f",Double(course.credit)))
        
        tableView.separatorInset = UIEdgeInsets(top: 100, left: 100, bottom: 0, right: 0)
       
        cell.frameLayer.layer.borderWidth = 1.0
        cell.frameLayer.layer.borderColor = UIColor(netHex: 0x502075).cgColor
        cell.frameLayer.layer.cornerRadius = 4.0
        cell.frameLayer.clipsToBounds = true
       
        cell.accessoryType = .disclosureIndicator
        
    
      
        
        
        return cell
        
    }
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if(editingStyle == UITableViewCellEditingStyle.delete) {
            let credits = dataSet.courses[indexPath.row].credit
            dataSet.courses.remove(at: indexPath.row)
            dataSet.numberOfCredits -= credits
            tableView.deleteRows(at: [indexPath], with: .fade)
            NSKeyedArchiver.archiveRootObject(dataSet, toFile: CorseManager.ArchiveURL.path)
            if(dataSet.courses.count == 0) {
            recheckView()
            navBar.rightBarButtonItem?.isEnabled = false
            }

        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let frame  = tableView.rectForRow(at: indexPath)
        
        let frameToOpenFrom = tableView.convert(frame, to: tableView.superview)
        openingFrame = frameToOpenFrom
        OpeningFrame = openingFrame
	 
		
		let cell = tableView.cellForRow(at: indexPath)
		UIView.animate(withDuration: 0.2, animations: {
			cell!.layer.transform = CATransform3DMakeTranslation(400, 0, 0)

			}, completion: { (finished) in
				self.doStuff(indexPath.row)

		}) 
		
	}
    
    func doStuff(_ index: Int) {
               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
       let vc : UINavigationController = storyBoard.instantiateViewController(withIdentifier: "navEditController") as! UINavigationController
        
        edittingIndex = index
        offset_table = tableView.contentOffset.y;
        vc.transitioningDelegate  = self
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
   
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    @IBAction func editAll(_ sender: UIBarButtonItem) {
        if(!StyeleEdit) {
            navBar.rightBarButtonItem?.title = "Done"
            navBar.rightBarButtonItem?.style = .done
            tableView.setEditing(true, animated: true)
            StyeleEdit = true
        } else {
            sender.title = "Edit"
            navBar.rightBarButtonItem?.style = .plain
            tableView.setEditing(false, animated: true)
            StyeleEdit = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
		offset_table = 0.0
        let toViewController = segue.destination as UIViewController
        
        toViewController.modalPresentationStyle = .custom
        toViewController.transitioningDelegate = self.transition
        
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let trans = ExpandAnimator.animator
        trans.openingFrame = openingFrame!
        
        return trans
    }

    
 
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let text:NSString = "No Courses"


        let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 22.0)]
        return NSAttributedString(string: text as String, attributes: attributes)
     
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let text:NSString = "To add a course, tap the add icon in the Main Menu."
        
        
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
        return NSAttributedString(string: text as String, attributes: attributes)
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return dataSet.courses.count == 0
    }
    
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "placeholder")
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        
        return UIColor.white
    }
    
    
    
    func recheckView() {
        UIView.animate(withDuration: 0.5, animations: {
             self.tableView.reloadData()
            }, completion: nil)
        
            self.navBar.rightBarButtonItem?.title = "Edit"
            self.navBar.rightBarButtonItem?.style = .plain
            self.tableView.setEditing(false, animated: true)
            self.StyeleEdit = false
            
        

    }
	
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if(indexPath.row == edittingIndex) {
			
			let seconds = 0.6
			let delay = seconds * Double(NSEC_PER_SEC)
			let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
			
			
			DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
				
				cell.layer.transform = CATransform3DMakeTranslation(400, 0, 0)
				UIView.animate(withDuration: 0.5, animations: {
					cell.layer.transform = CATransform3DMakeTranslation(0, 0, 0)
					}, completion: { (finished) in
						edittingIndex = -1
				})
		
			}
			
		}
	}
}
    
