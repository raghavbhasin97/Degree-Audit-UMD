//
//  DegreePrograms.swift
//  Audit
//
//  Created by Raghav Bhasin on 6/23/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit

class DegreePrograms : UIViewController, UITableViewDelegate, UITableViewDataSource,UIPopoverPresentationControllerDelegate , UIViewControllerTransitioningDelegate{
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationItem!
    let transition = slideTransition(style: .slideRight)
     let trans = cellDetailAnimation()

    @IBOutlet weak var table: UITableView!
    

    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
	
	
	var shouldLoad: [Bool] = [true,true,true,true]
  

    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButton()
        table.delegate = self
        table.dataSource = self
               
        table.tableFooterView = UIView()
       
        
               navigationBar.titleTextAttributes
                = [NSForegroundColorAttributeName: UIColor(netHex: 0x05750A),
               NSFontAttributeName: UIFont(name: "ChalkboardSE-Bold", size: 20.0)!]

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return degreesData.degrees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.separatorInset = UIEdgeInsetsMake(0, 100, 0, 0)
        let identifier = "progCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
        programTableViewCell
        
        let degree = degreesData.degrees[indexPath.row]
        cell.type!.text = degree.type
        cell.type?.font = UIFont(name: "Marker Felt", size: 18)
        cell.type?.textColor = UIColor.blue.withAlphaComponent(0.6)
        cell.desc.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        cell.Gpa.font = UIFont(name: "HelveticaNeue-Bold", size: 13)
        
       let circleChart = PNCircleChart(frame: CGRect(x: 40,y: 20, width: 20, height: 100.0), total: NSNumber(value: 100 as Int), current: NSNumber(value: 0 as Int), clockwise: false, shadow: true, shadowColor: UIColor.lightGray.withAlphaComponent(0.67), displayCountingLabel: true, overrideLineWidth: NSNumber(value: 8 as Int))
        
        
        circleChart?.backgroundColor = UIColor.clear
        circleChart?.strokeColor = UIColor.blue
        if(isReturning) {
         circleChart?.displayAnimated = false
        } else {
        circleChart?.displayAnimated = true
        }
        circleChart?.stroke()
        isReturning = true
        
        circleChart?.backgroundColor = UIColor.clear
        cell.chartView.addSubview(circleChart!)

        if(degree.type == "MAJOR") {
            let num = dataSet.returnMCreditsPercent()
            let index = degree.type.index(degree.type.startIndex, offsetBy: 1)
            let str = degree.type.substring(from: index).lowercased()
            cell.desc!.text = "A M\(str) in \(degree.field)"
            if(dataSet.courses.count == 0) {
                  cell.Gpa!.text = "GPA: " + "N/A"
            } else {
            cell.Gpa!.text = "GPA: " + String(NSString(format:"%0.3f",dataSet.majorCoursesGPA()))
            }
            circleChart?.update(byCurrent: NSNumber(value: num as Int))
      
            
        }
        else if(degree.type == "GENED") {
            cell.desc!.text = "A General Eductaion Degree is a part of Major Degree"
            if(dataSet.courses.count == 0) {
                cell.Gpa!.text = "GPA: " + "N/A"
            } else {

            cell.Gpa!.text = "GPA: " + String(NSString(format:"%0.3f",dataSet.genEdCoursesGPA()))
            }
            let num = dataSet.returnGCreditsPercent()
            circleChart?.update(byCurrent: NSNumber(value: num as Int))
          
        }
        cell.desc?.textColor = UIColor.black.withAlphaComponent(0.8)
      cell.accessoryType = .disclosureIndicator
        
        if(indexPath.row == 1) {
        cell.index = indexPath
        }
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(indexPath.row > 1) {
            if(editingStyle == UITableViewCellEditingStyle.delete) {
               degreesData.degrees.remove(at: indexPath.row)
                
                NSKeyedArchiver.archiveRootObject(degreesData, toFile: DegreeManager.ArchiveURL.path)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        }
        else {
            if(editingStyle == .delete) {
                let alert = UIAlertController(title: "Error", message: "Major Degree Program cannot be removed.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                table.reloadData()
            }
        }
        
        }
    
  
 func addPop() {
    
   
    self.tableHeight.constant += 200.0
    
    UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: {
        self.view.layoutIfNeeded()
        }, completion: nil)
    
    let storyboard : UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
    let popOver:UIViewController = storyboard.instantiateViewController(withIdentifier: "addDegree")
    
    popOver.modalPresentationStyle = .popover
    popOver.preferredContentSize = CGSize(width: 400, height: 200)
    
    
    let popoverMenuViewController = popOver.popoverPresentationController
    popoverMenuViewController?.permittedArrowDirections = .any
    popoverMenuViewController?.delegate = self
    popoverMenuViewController?.sourceView = self.view
    popoverMenuViewController?.sourceRect = CGRect(x: 334.0, y: 56, width: 1,height: 1)
    
    present(popOver,animated: true,completion: nil)
    }
    
    func adaptivePresentationStyle(
        for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if(indexPath.row == 0) {
            // Gened
           
            
            let cell = tableView.cellForRow(at: indexPath) as! programTableViewCell
            trans.chatView = cell.chartView.subviews[0].frame
            trans.table = self.table
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc : UIViewController = storyBoard.instantiateViewController(withIdentifier: "genEd")
            vc.transitioningDelegate  = self
            vc.modalPresentationStyle = .custom

            self.present(vc, animated: true, completion: nil)
            
        } else if (indexPath.row == 1) {
            // Major
            
            let cell = tableView.cellForRow(at: indexPath) as! programTableViewCell
            
            let frame = cell.chartView.subviews[0].frame
     

            
           
            trans.chatView = CGRect(x: frame.origin.x, y: frame.origin.y + 150, width: frame.size.width, height: frame.size.height)
            trans.table = self.table
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc : UIViewController = storyBoard.instantiateViewController(withIdentifier: "major")
            vc.transitioningDelegate  = self
            vc.modalPresentationStyle = .custom
          
            self.present(vc, animated: true, completion: nil)

        } else {
           // Minor
        }
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        self.tableHeight.constant -= 200.0
        let b = navItem.rightBarButtonItem?.value(forKey: "view") as! PaperButtonTwo
        b.touchUp(insideHandler: b)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: UIViewAnimationOptions(), animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        isReturning = false
        
        let toViewController = segue.destination as UIViewController
        
        toViewController.modalPresentationStyle = .custom
        toViewController.transitioningDelegate = self.transition
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            isReturning = true
            return trans
    }

    
    
    func addBarButton() {
        
        let button: PaperButtonTwo = PaperButtonTwo(frame: CGRect(x: self.view.frame.origin.x,
            y: self.view.frame.origin.y,
            width: 24,
            height: 17))
        button.addTarget(self, action: #selector(DegreePrograms.addPop), for: .touchUpInside)
        button.tintColor = UIColor.black
        let barButton = UIBarButtonItem(customView: button)
        
        self.navItem.rightBarButtonItem = barButton
        
    }
	
	

    
  
}
