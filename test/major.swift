//
//  major.swift
//  Audit
//
//  Created by Raghav Bhasin on 6/26/16.
//  Copyright © 2016 3Test Apps. All rights reserved.
//
import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class major: UIViewController, UITableViewDelegate, UITableViewDataSource ,UIViewControllerTransitioningDelegate{
    
    let transition = cellDetailDeanimator()

 
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var chartHolder: UIView!
    
    
    //MARK: TableView  refrences
    @IBOutlet weak var distributives: UITableView!
    @IBOutlet weak var loweLeveTable: UITableView!
    @IBOutlet weak var upperLevelTable: UITableView!
    @IBOutlet weak var upperLevelMajor: UILabel!
    @IBOutlet weak var electivesTable: UITableView!
    @IBOutlet weak var distance: NSLayoutConstraint!
    @IBOutlet weak var upperLevelConc: UITableView!
    @IBOutlet weak var viewSize: NSLayoutConstraint!
    

    var code:String = ""
    
    //MARK: Description Arrays
    var loweLeveArrDesc = ["Math Requirement","Computer Science Courses"]
    var upperLevelArrDesc = ["Computer Science", "Concentrations"]
    var distribArrDesc = ["Systems","Information Processing","Software Engineering","Theory","Numerical Analysis"]
    
    //MARK: Data Containers lower and Upper level
    var lowerLevels: [String] = []
    var mathReqs: [String] = ["", "" , "" , ""]
    var upperLevelReqs: [String] = ["", ""]
   
    
    //MARK: Distributive data Containers
    var systems:[String] = []
    var information: [String] = []
    var software:[String] = []
    var theory:[String] = []
    var analysis:[String] = []
   
    //MARK: Electives
    var electives:[String] = []
    
    var upperLevelConcentrations:[String] = []
    //MARK: Basic functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
     let data = extractDataSet()
        lowerLevelReqs(data)
        lowerLevelMath(data)
        upperLevelReqs(data)
        callDistributives(data)
      distributiveCoursesDataTrack = []
        
       upperLevelConcentrations = UpperLevelConc()
        
        navigationBar.titleTextAttributes
            = [NSForegroundColorAttributeName: UIColor.blue.withAlphaComponent(0.6),
               NSFontAttributeName: UIFont(name: "Marker Felt", size: 18)!]
        
        let circleChart = PNCircleChart(frame: CGRect(x: 120,y: 0, width: 20, height: 100.0), total: NSNumber(value: 100 as Int), current: NSNumber(value: 2 as Int), clockwise: false, shadow: true, shadowColor: UIColor.lightGray.withAlphaComponent(0.67), displayCountingLabel: true, overrideLineWidth: NSNumber(value: 8 as Int))
        
        
        circleChart?.backgroundColor = UIColor.clear
        circleChart?.strokeColor = UIColor.blue
        circleChart?.displayAnimated = false
        circleChart?.stroke()
        
        
        circleChart?.backgroundColor = UIColor.clear
        let num = dataSet.returnMCreditsPercent()
        circleChart?.update(byCurrent: NSNumber(value: num as Int))
        
        
        chartHolder.addSubview(circleChart!)
        
        
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }

       //MARK: TableView Delegates and DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == loweLeveTable) {
        return loweLeveArrDesc.count
        } else if(tableView == upperLevelTable) {
            return 1
        } else if(tableView == distributives) {
            return distribArrDesc.count
        }else if(tableView == electivesTable){
            return 1
        } else if(tableView == upperLevelConc) {
            return 1
        }         else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if(tableView == loweLeveTable) {
            
        let identifier = "lowerLevelReqs"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
        majotTableViewCell
        
        tableView.rowHeight = 120

        cell.classification.text! = loweLeveArrDesc[indexPath.row]
        cell.classification?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        cell.grade1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.name1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.credit1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.desc1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.grade2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.name2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.credit2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.desc2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.grade3?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.name3?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.credit3?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.desc3?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.grade4?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.name4?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.credit4?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.desc4?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
  
        if(indexPath.row == 1) {
        var data1 = lowerLevels[0].components(separatedBy: ",")
        cell.name1.text = data1[0]
            if(data1[2] != "") {
        cell.credit1.text = String(NSString(format: "%.2f",Double(data1[2])!))
            } else {
                cell.credit1.text = ""
            }
        cell.grade1.text = data1[1]
        cell.desc1.text = data1[4]
            if( data1[0] == "") {
             
                cell.name1.text = "Needs CMSC131: Object Oriented Programming I"
                cell.name1.textColor = UIColor.blue
            }
        
        var data2 = lowerLevels[1].components(separatedBy: ",")
        cell.name2.text = data2[0]
            if(data2[2] != "") {
        cell.credit2.text = String(NSString(format: "%.2f",Double(data2[2])!))
            }
            else {
                cell.credit2.text = ""
            }
        cell.grade2.text = data2[1]
        cell.desc2.text = data2[4]
        
            if( data2[0] == "") {
                 cell.name2.text = "Needs CMSC132: Object Oriented Programmoing II"
                 cell.name2.textColor = UIColor.blue
           
            }
        var data3 = lowerLevels[2].components(separatedBy: ",")
        cell.name3.text = data3[0]
            if(data3[2] != "") {
        cell.credit3.text = String(NSString(format: "%.2f",Double(data3[2])!))
            }
            else {
                cell.credit3.text = ""
            }
        cell.grade3.text = data3[1]
        cell.desc3.text = data3[4]
            
            if( data3[0] == "") {

                cell.name3.text = "Needs CMSC250: Discrete Structures"
                 cell.name3.textColor = UIColor.blue
            }
        
        var data4 = lowerLevels[3].components(separatedBy: ",")
        cell.name4.text = data4[0]
            if(data4[2] != "") {
        cell.credit4.text = String(NSString(format: "%.2f",Double(data4[2])!))
            }
            else {
                cell.credit4.text = ""
            }
        cell.grade4.text = data4[1]
        cell.desc4.text = data4[4]
            
            if( data4[0] == "") {
            cell.name4.text = "Needs CMSC216: Intro to Computer Systems"
                 cell.name4.textColor = UIColor.blue
              
            }
        }
        
        else {
            var data1 = mathReqs[0].components(separatedBy: ",")
            cell.name1.text = data1[0]
            if(data1[2] != "") {
                cell.credit1.text = String(NSString(format: "%.2f",Double(data1[2])!))
            } else {
                cell.credit1.text = ""
            }
            cell.grade1.text = data1[1]
            cell.desc1.text = data1[4]
            if( data1[0] == "") {
                
                cell.name1.text = "Needs MATH140 CALCULUS I"
                 cell.name1.textColor = UIColor.blue
            }
            
            var data2 = mathReqs[1].components(separatedBy: ",")
            cell.name2.text = data2[0]
            if(data2[2] != "") {
                cell.credit2.text = String(NSString(format: "%.2f",Double(data2[2])!))
            }
            else {
                cell.credit2.text = ""
            }
            cell.grade2.text = data2[1]
            cell.desc2.text = data2[4]
            
            if( data2[0] == "") {
                               cell.name2.text = "Needs MATH141 CALCULUS II"
                 cell.name2.textColor = UIColor.blue
               
            }
            var data3 = mathReqs[2].components(separatedBy: ",")
            cell.name3.text = data3[0]
            if(data3[2] != "") {
                cell.credit3.text = String(NSString(format: "%.2f",Double(data3[2])!))
            }
            else {
                cell.credit3.text = ""
            }
            cell.grade3.text = data3[1]
            cell.desc3.text = data3[4]
            
            if( data3[0] == "") {
               
                cell.name3.text = "Needs a 200 Level MATH course"
                 cell.name3.textColor = UIColor.blue
            }
            
            var data4 = mathReqs[3].components(separatedBy: ",")
            cell.name4.text = data4[0]
            if(data4[2] != "") {
                cell.credit4.text = String(NSString(format: "%.2f",Double(data4[2])!))
            }
            else {
                cell.credit4.text = ""
            }
            cell.grade4.text = data4[1]
            cell.desc4.text = data4[4]
            
            if( data4[0] == "") {
                cell.name4.text = "Needs a STAT course (STAT400/STAT401)"
                 cell.name4.textColor = UIColor.blue
            }

        }
       
        
            return cell
        } else if(tableView == upperLevelTable){
            let identifier = "upperlevel"
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
            degreeTwoTableViewCell
            
            cell.classification.text = "Computer Science"
            cell.classification?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
            cell.name1.text = ""
            cell.credit1.text = ""
            cell.grade1.text = ""
            cell.desc1.text = ""
            cell.name2.text = ""
            cell.credit2.text = ""
            cell.grade2.text = ""
            cell.desc2.text = ""
            cell.grade1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.name1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.credit1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.desc1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.grade2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.name2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.credit2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.desc2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)

            var data1 = upperLevelReqs[0].components(separatedBy: ",")
            cell.name1.text = data1[0]
            if(data1[2] != "") {
                cell.credit1.text = String(NSString(format: "%.2f",Double(data1[2])!))
            } else {
                cell.credit1.text = ""
            }
            cell.grade1.text = data1[1]
            cell.desc1.text = data1[4]
            if( data1[0] == "") {
                
                cell.name1.text = "Needs CMSC330: Organization of Programming Languages"
                cell.name1.textColor = UIColor.blue
            }
            
            var data2 = upperLevelReqs[1].components(separatedBy: ",")
            cell.name2.text = data2[0]
            if(data2[2] != "") {
                cell.credit2.text = String(NSString(format: "%.2f",Double(data2[2])!))
            }
            else {
                cell.credit2.text = ""
            }
            cell.grade2.text = data2[1]
            cell.desc2.text = data2[4]
            
            if( data2[0] == "") {
                cell.name2.text = "Needs CMSC351: Algorithms"
                cell.name2.textColor = UIColor.blue
                
            }
            
            
            return cell
        }
        
        else if(tableView == distributives){
            let identifier = "distribCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
                distributivesTableViewCell
            
            cell.classification.text = distribArrDesc[indexPath.row]
            cell.classification?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
            cell.name1.text = ""
            cell.credit1.text = ""
            cell.grade1.text = ""
            cell.desc1.text = ""
            cell.name2.text = ""
            cell.credit2.text = ""
            cell.grade2.text = ""
            cell.desc2.text = ""
            cell.needs.text = ""
            cell.grade1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.name1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.credit1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.desc1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.grade2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.name2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.credit2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.desc2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.needs?.font = UIFont(name: "HelveticaNeue-Bold", size: 10)
            
            if(indexPath.row == 0) {
                if(systems.count == 0 && (information.count + software.count + theory.count + analysis.count) < 5) {
                    cell.needs.text = "SELECT FROM: CMSC 411, 412, 414, 417"
                    cell.needs.textColor = UIColor.blue

                } else if(systems.count == 1) {
                var data = systems[0].components(separatedBy: ",")
                    cell.name1.text = data[0]
                   
                        cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    
                   cell.grade1.text = data[1]
                    cell.desc1.text = data[4]
                  distributives.rowHeight = 50
                  distributives.frame.size.height -= 30
                  distributiveCoursesDataTrack.append(systems[0])
                }
                else if (systems.count == 2 && distributiveCoursesDataTrack.count < 5)
                {
                    var data = systems[0].components(separatedBy: ",")
                    cell.name1.text = data[0]
                    
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    
                    cell.grade1.text = data[1]
                    cell.desc1.text = data[4]
                    
                    var data2 = systems[1].components(separatedBy: ",")
                    cell.name2.text = data2[0]
                    
                    cell.credit2.text = String(NSString(format: "%.2f",Double(data2[2])!))
                    
                    cell.grade2.text = data2[1]
                    cell.desc2.text = data2[4]
                    distributiveCoursesDataTrack.append(systems[0])
                    distributiveCoursesDataTrack.append(systems[1])


                } else {
                    cell.needs.text = "----Distributives satisfied----"
                    
                }
               
            } else if(indexPath.row == 1) {
                 distributives.rowHeight = 80
                if(information.count == 0 && (systems.count + software.count + theory.count + analysis.count) < 5) {
                    cell.needs.text = "SELECT FROM: CMSC 420, 421, 422, 423, 424, 426, 427"
                    cell.needs.textColor = UIColor.blue
                    
                } else if(information.count == 1) {
                    
                    var data = information[0].components(separatedBy: ",")
                    cell.name1.text = data[0]
                    
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    
                    cell.grade1.text = data[1]
                    cell.desc1.text = data[4]
                    distributives.rowHeight = 50
                    distributives.frame.size.height -= 30
                    distributiveCoursesDataTrack.append(information[0])

                }
                else if (information.count == 2)
                {
                    var data = information[0].components(separatedBy: ",")
                    cell.name1.text = data[0]
                    
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    
                    cell.grade1.text = data[1]
                    cell.desc1.text = data[4]
                    
                    var data2 = information[1].components(separatedBy: ",")
                    cell.name2.text = data2[0]
                    
                    cell.credit2.text = String(NSString(format: "%.2f",Double(data2[2])!))
                    
                    cell.grade2.text = data2[1]
                    cell.desc2.text = data2[4]
                    distributiveCoursesDataTrack.append(information[0])
                    distributiveCoursesDataTrack.append(information[1])
                }
                else {
                    cell.needs.text = "----Distributives satisfied----"
                }
            }else if(indexPath.row == 2) {
                 distributives.rowHeight = 80
                if(software.count == 0 && (distributiveCoursesDataTrack.count + analysis.count + theory.count) < 5) {
                    cell.needs.text = "SELECT FROM: CMSC 430, 433, 434, 435, 436"
                    cell.needs.textColor = UIColor.blue
                    
                }  else if((software.count == 1 || software.count == 2) && ((distributiveCoursesDataTrack.count +  software.count <= 4) || distributiveCoursesDataTrack.count == 4))  {

                    var data = software[0].components(separatedBy: ",")
                    cell.name1.text = data[0]
                    
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    
                    cell.grade1.text = data[1]
                    cell.desc1.text = data[4]
                    distributives.rowHeight = 50
                    distributives.frame.size.height -= 30
                    distributiveCoursesDataTrack.append(software[0])
                }
                else if (software.count == 2 && distributiveCoursesDataTrack.count < 5)
                {
                    var data = software[0].components(separatedBy: ",")
                    cell.name1.text = data[0]
                    
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    
                    cell.grade1.text = data[1]
                    cell.desc1.text = data[4]
                    
                    var data2 = software[1].components(separatedBy: ",")
                    cell.name2.text = data2[0]
                    
                    cell.credit2.text = String(NSString(format: "%.2f",Double(data2[2])!))
                    
                    cell.grade2.text = data2[1]
                    cell.desc2.text = data2[4]
                    distributiveCoursesDataTrack.append(software[0])
                    distributiveCoursesDataTrack.append(software[1])
                }
                else {
                    cell.needs.text = "----Distributives satisfied----"
                   
                }
            }else if(indexPath.row == 3) {
                 distributives.rowHeight = 80
           
                if(theory.count == 0 && distributiveCoursesDataTrack.count < 5) {
                    cell.needs.text = "SELECT FROM: CMSC 451, 452, 456"
                    cell.needs.textColor = UIColor.blue
                    
                }  else if((theory.count == 1 || theory.count == 2) && (distributiveCoursesDataTrack.count +  theory.count <= 4 || distributiveCoursesDataTrack.count == 4)) {
                    var data = theory[0].components(separatedBy: ",")
                    cell.name1.text = data[0]
                    
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    
                    cell.grade1.text = data[1]
                    cell.desc1.text = data[4]
                    distributives.rowHeight = 50
                    distributives.frame.size.height -= 30
                    distributiveCoursesDataTrack.append(theory[0])
                }
                else if (theory.count == 2 && distributiveCoursesDataTrack.count < 5)
                {
                    var data = theory[0].components(separatedBy: ",")
                    cell.name1.text = data[0]
                    
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    
                    cell.grade1.text = data[1]
                    cell.desc1.text = data[4]
                    
                    var data2 = theory[1].components(separatedBy: ",")
                    cell.name2.text = data2[0]
                    
                    cell.credit2.text = String(NSString(format: "%.2f",Double(data2[2])!))
                    
                    cell.grade2.text = data2[1]
                    cell.desc2.text = data2[4]
                     distributiveCoursesDataTrack.append(theory[0])
                     distributiveCoursesDataTrack.append(theory[1])
                }
                else {
                    cell.needs.text = "----Distributives satisfied----"
                
                }
            }else if(indexPath.row == 4) {
                 distributives.rowHeight = 80
                if(analysis.count == 0 && distributiveCoursesDataTrack.count < 5) {
                    cell.needs.text = "SELECT FROM: CMSC 460, 466"
                    cell.needs.textColor = UIColor.blue
                    
                }  else if((analysis.count == 1 || analysis.count == 2) && (distributiveCoursesDataTrack.count +  analysis.count <= 4  || distributiveCoursesDataTrack.count == 4))  {
                    var data = analysis[0].components(separatedBy: ",")
                    cell.name1.text = data[0]
                    
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    
                    cell.grade1.text = data[1]
                    cell.desc1.text = data[4]
                    distributives.rowHeight = 50
                    distributives.frame.size.height -= 30
                     distributiveCoursesDataTrack.append(analysis[0])

                }
                else if (analysis.count == 2 && distributiveCoursesDataTrack.count < 5)
                { var data = analysis[0].components(separatedBy: ",")
                    cell.name1.text = data[0]
                    
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    
                    cell.grade1.text = data[1]
                    cell.desc1.text = data[4]
                    
                    var data2 = analysis[1].components(separatedBy: ",")
                    cell.name2.text = data2[0]
                    
                    cell.credit2.text = String(NSString(format: "%.2f",Double(data2[2])!))
                    
                    cell.grade2.text = data2[1]
                    cell.desc2.text = data2[4]
                    distributiveCoursesDataTrack.append(analysis[0])
                    distributiveCoursesDataTrack.append(analysis[1])
                    
                }
                else {
                    cell.needs.text = "----Distributives satisfied----"
                    
                }
            }
            return cell
        } else if(tableView == electivesTable){
            let identifier = "electives"
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
                electivesTableViewCell
            cell.name1.text = ""
            cell.credit1.text = ""
            cell.grade1.text = ""
            cell.desc1.text = ""
            cell.name2.text = ""
            cell.credit2.text = ""
            cell.grade2.text = ""
            cell.desc2.text = ""
            cell.grade1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.name1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.credit1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.desc1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.grade2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.name2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.credit2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.desc2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            var data1 = electives[0].components(separatedBy: ",")
            cell.name1.text = data1[0]
            if(data1[2] != "") {
                cell.credit1.text = String(NSString(format: "%.2f",Double(data1[2])!))
            } else {
                cell.credit1.text = ""
            }
            cell.grade1.text = data1[1]
            cell.desc1.text = data1[4]
            if( data1[0] == "") {
                
                cell.name1.text = "Needs 3 Credits at the CMSC300/400 Level"
                cell.name1.textColor = UIColor.blue
            }
            
            var data2 = electives[1].components(separatedBy: ",")
            cell.name2.text = data2[0]
            if(data2[2] != "") {
                cell.credit2.text = String(NSString(format: "%.2f",Double(data2[2])!))
            }
            else {
                cell.credit2.text = ""
            }
            cell.grade2.text = data2[1]
            cell.desc2.text = data2[4]
            
            if( data2[0] == "") {
                cell.name2.text = "Needs 3 Credits at the CMSC300/400 Level"
                cell.name2.textColor = UIColor.blue
                
            }
            checkConstraints()
            return cell
        } else {
            let identifier = "upperLevelConc"
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as!
            majotTableViewCell
            
            
            if(code != "") {
                cell.classification.text! = courseCode[code]!

            }
            
            
            cell.classification?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
            cell.grade1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.name1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.credit1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.desc1?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.grade2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.name2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.credit2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.desc2?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.grade3?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.name3?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.credit3?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.desc3?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.grade4?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.name4?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.credit4?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.desc4?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            
            
            var data1 = upperLevelConcentrations[0].components(separatedBy: ",")
            cell.name1.text = data1[0]
            if(data1[2] != "") {
                cell.credit1.text = String(NSString(format: "%.2f",Double(data1[2])!))
            } else {
                cell.credit1.text = ""
            }
            cell.grade1.text = data1[1]
            cell.desc1.text = data1[4]
            if( data1[0] == "") {
                
                cell.name1.text = "Complete 4 courses at the 300-400 level in an area outside CMSC."
                cell.name1.textColor = UIColor.blue
                tableView.rowHeight -= 22.0
                upperLevelConc.frame.size.height -= 30.0
                viewSize.constant -= 30
            }
            
            var data2 = upperLevelConcentrations[1].components(separatedBy: ",")
            cell.name2.text = data2[0]
            if(data2[2] != "") {
                cell.credit2.text = String(NSString(format: "%.2f",Double(data2[2])!))
            }
            else {
                cell.credit2.text = ""
            }
            cell.grade2.text = data2[1]
            cell.desc2.text = data2[4]
            
            if( data2[0] == "") {
                cell.name2.text = "Complete 4 courses at the 300-400 level in an area outside CMSC."
                cell.name2.textColor = UIColor.blue
                 tableView.rowHeight -= 22.0
                  upperLevelConc.frame.size.height -= 30.0
                  viewSize.constant -= 30
                
            }
            var data3 = upperLevelConcentrations[2].components(separatedBy: ",")
            cell.name3.text = data3[0]
            if(data3[2] != "") {
                cell.credit3.text = String(NSString(format: "%.2f",Double(data3[2])!))
            }
            else {
                cell.credit3.text = ""
            }
            cell.grade3.text = data3[1]
            cell.desc3.text = data3[4]
            
            if( data3[0] == "") {
                
                cell.name3.text = "Complete 4 courses at the 300-400 level in an area outside CMSC."
                cell.name3.textColor = UIColor.blue
                 tableView.rowHeight -= 22.0
                  upperLevelConc.frame.size.height -= 30.0
                viewSize.constant -= 30
            }
            
            var data4 = upperLevelConcentrations[3].components(separatedBy: ",")
            cell.name4.text = data4[0]
            if(data4[2] != "") {
                cell.credit4.text = String(NSString(format: "%.2f",Double(data4[2])!))
            }
            else {
                cell.credit4.text = ""
            }
            cell.grade4.text = data4[1]
            cell.desc4.text = data4[4]
            
            if( data4[0] == "") {
                cell.name4.text = "Complete 4 courses at the 300-400 level in an area outside CMSC."
                cell.name4.textColor = UIColor.blue
            }

            return cell
        }
    }
    
    
    // MARK: Course Classifications
    func islovwerLevel(_ name :String) -> Bool {
        
        let str = (name.substring(from: name.characters.index(name.startIndex, offsetBy: 4)))
        let courseNumber = Int(str.substring(to: str.characters.index(str.startIndex, offsetBy: 3)))
        return (courseNumber < 300)
    }
    
    
    func isUpperLevel(_ name :String) -> Bool {
        
        let str = (name.substring(from: name.characters.index(name.startIndex, offsetBy: 4)))
        let courseNumber = Int(str.substring(to: str.characters.index(str.startIndex, offsetBy: 3)))
        return (courseNumber > 300) && (courseNumber < 400)
    }
    
    func isDistributve(_ name :String) -> Bool {
        
        let str = (name.substring(from: name.characters.index(name.startIndex, offsetBy: 4)))
        let courseNumber = Int(str.substring(to: str.characters.index(str.startIndex, offsetBy: 3)))
        return (courseNumber > 400)
    }

    
    //MARK: TableData Extract
    
    func extractDataSet() -> CorseManager {
        let majorDataset = CorseManager()
        
        for course in dataSet.courses {
            if(course.requirements.components(separatedBy: ",").contains("CORE")) {
                majorDataset.courses.append(course)
                majorDataset.numberOfCredits += course.credit
            }
        }
        
        return majorDataset
    }
    
    
    func lowerLevelReqs(_ data: CorseManager) {
        for course in data.courses {
            if(course.name.contains("CMSC")) {
                if(islovwerLevel(course.name)) {
                    if(course.name == "CMSC131" && course.term == "AP") {
                        lowerLevels.append((course.name + "," + ("T" + course.gradeEarned) + "," + String(course.credit) + "," + course.term + "," + "ADVANCED PLACEMENT"))
                    } else {
                        lowerLevels.append((course.name + "," + course.gradeEarned + "," + String(course.credit) + "," + course.term + "," + course.desc))
                    }
                }
            }
        }
        
        var length = lowerLevels.count
        
        if(length < 4) {
            while length < 4 {
                lowerLevels.append(("" + "," + "" + "," + "" + "," + "" + "," + ""))
                length += 1
            }
        }
    }
    

    func lowerLevelMath(_ data: CorseManager) {
           var index = 0
        for course in data.courses {
            if(course.name.contains("MATH") || course.name.contains("STAT") ) {
                if(!course.name.contains("STAT")) {
                if(course.term == "AP") {
                     mathReqs[index] = ((course.name + "," + ("T" + course.gradeEarned) + "," + String(course.credit) + "," + course.term + "," + "ADVANCED PLACEMENT"))
                } else {
                    mathReqs[index] = ((course.name + "," + course.gradeEarned + "," + String(course.credit) + "," + course.term + "," + course.desc))
                }
                    
                     index += 1
            }
                else {
                    mathReqs[3] = (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," + course.term + "," + course.desc)
                }
             
                
            }
        }
        
         index = 0
        while (index < 4) {
            if(mathReqs[index] == ""){
                mathReqs[index] = (("" + "," + "" + "," + "" + "," + "" + "," + ""))
            }
            index += 1
        }
    }
    
    
    
    func upperLevelReqs(_ data: CorseManager) {
        var index = 0

        for course in data.courses {
        if(course.name.contains("CMSC")) {
                if(isUpperLevel(course.name)) {
                    if(course.name == "CMSC330" || course.name == "CMSC351") {
                       upperLevelReqs[index] = ((course.name + "," + course.gradeEarned + "," + String(course.credit) + "," + course.term + "," + course.desc))
                        index += 1
                    } else {
                        upperLevelReqs.append((course.name + "," + course.gradeEarned + "," + String(course.credit) + "," + course.term + "," + course.desc))
                    }
                    
                }
            }

        }
        
        index = 0
        while (index < 2) {
            if(upperLevelReqs[index] == ""){
                upperLevelReqs[index] = (("" + "," + "" + "," + "" + "," + "" + "," + ""))
            }
            index += 1
        }

    }
    
    func ditributives(_ data: CorseManager) -> [Course] {
        var distributivesData: [Course] = []
        
        for element in data.courses {
            if(element.name.contains("CMSC") && isDistributve(element.name)) {
                distributivesData.append(element)
            }
        }
        
        return distributivesData
    }
    
    // MARK: Distributives Classinfication
    func systemsCourse(_ name :String) -> Bool {
        
        let str = (name.substring(from: name.characters.index(name.startIndex, offsetBy: 4)))
        let courseNumber = Int(str.substring(to: str.characters.index(str.startIndex, offsetBy: 3)))
        let midDig = (courseNumber!/10)%10
        return (midDig == 1)
    }
    
    func informationCourse(_ name :String) -> Bool {
        
        let str = (name.substring(from: name.characters.index(name.startIndex, offsetBy: 4)))
        let courseNumber = Int(str.substring(to: str.characters.index(str.startIndex, offsetBy: 3)))
        let midDig = (courseNumber!/10)%10
        return (midDig == 2)
    }
    func softwareCourse(_ name :String) -> Bool {
        
        let str = (name.substring(from: name.characters .index(name.startIndex, offsetBy: 4)))
        let courseNumber = Int(str.substring(to: str.characters.index(str.startIndex, offsetBy: 3)))
        let midDig = (courseNumber!/10)%10
        return (midDig == 3)
    }
    func theoryCourse(_ name :String) -> Bool {
        
        let str = (name.substring(from: name.characters.index(name.startIndex, offsetBy: 4)))
        let courseNumber = Int(str.substring(to: str.characters.index(str.startIndex, offsetBy: 3)))
        let midDig = (courseNumber!/10)%10
        return (midDig == 5)
    }
    func analysisCourse(_ name :String) -> Bool {
        
        let str = (name.substring(from: name.characters.index(name.startIndex, offsetBy: 4)))
        let courseNumber = Int(str.substring(to: str.characters.index(str.startIndex, offsetBy: 3)))
        let midDig = (courseNumber!/10)%10
        return (midDig == 6)
    }
    
    // MARK: Distributives Extraction
    
    func extractSystems(_ distributiveCourses :[Course]) {
        for course in distributiveCourses {
            if(systemsCourse(course.name)) {
                systems.append((course.name + "," + course.gradeEarned + "," + String(course.credit) + "," + course.term + "," + course.desc))
            }
        }
    }
    
    func extractInformation(_ distributiveCourses :[Course]) {
        for course in distributiveCourses {
            if(informationCourse(course.name)) {
                information.append((course.name + "," + course.gradeEarned + "," + String(course.credit) + "," + course.term + "," + course.desc))
            }
        }
    }
    
    func extractSoftware(_ distributiveCourses :[Course]) {
        for course in distributiveCourses {
            if(softwareCourse(course.name)) {
                software.append((course.name + "," + course.gradeEarned + "," + String(course.credit) + "," + course.term + "," + course.desc))
            }
        }
        
    }
    
    func extractTheory(_ distributiveCourses :[Course]) {
        for course in distributiveCourses {
            if(theoryCourse(course.name)) {
                theory.append((course.name + "," + course.gradeEarned + "," + String(course.credit) + "," + course.term + "," + course.desc))
            }
        }
    }
    
    func extractAnalysis(_ distributiveCourses :[Course]) {
        for course in distributiveCourses {
            if(analysisCourse(course.name)) {
                analysis.append((course.name + "," + course.gradeEarned + "," + String(course.credit) + "," + course.term + "," + course.desc))
            }
        }
    }
    
    //MARK: CALLS Distrib
    
    
    func callDistributives(_ data: CorseManager) {
        let distributivesCourse = ditributives(data)
        extractSystems(distributivesCourse)
        extractTheory(distributivesCourse)
        extractAnalysis(distributivesCourse)        
        extractSoftware(distributivesCourse)
        extractInformation(distributivesCourse)
        electives(distributivesCourse)
    }
    
    
    //MARK: Electives
    
    func electives(_ data: [Course]) {
       electives300L()
        if(data.count == 6) {
            let course = data[5]
            electives.append((course.name + "," + course.gradeEarned + "," + String(course.credit) + "," + course.term + "," + course.desc))
        } else if(data.count > 6) {
            var course = data[5]
            electives.append((course.name + "," + course.gradeEarned + "," + String(course.credit) + "," + course.term + "," + course.desc))
           
            course = data[6]
            electives.append((course.name + "," + course.gradeEarned + "," + String(course.credit) + "," + course.term + "," + course.desc))
        }
        
        
        if(electives.count == 0) {
             electives.append(("" + "," + ""     + "," + "" + "," + "" + "," + ""))
             electives.append(("" + "," + "" + "," + "" + "," + "" + "," + ""))
        }
        if(electives.count == 1) {
            electives.append(("" + "," + "" + "," + "" + "," + "" + "," + ""))
        }

        
    }
    
    func electives300L() {
        if(upperLevelReqs.count > 2) {
            var index = 2
            while(index < upperLevelReqs.count) {
                electives.append(upperLevelReqs[index])
                index += 1
            }
        }
    }
    
    // MARK: Upper Level Concentrations
    func UpperLevelConc() -> [String] {
        var names: [String] = []
        for course in dataSet.courses {
            if(course.qualifiesConc() && !course.name.contains("CMSC")){
               code = course.extractCode()
                for course2 in dataSet.courses{
                    if(course2.name.contains(code) && course2.qualifiesConc()) {
                        names.append((course2.name + "," + course2.gradeEarned + "," + String(course2.credit) + "," + course2.term + "," + course2.desc))
                    }
                    
                }
                
                if(names.count >= 3) {
                    break;
                }
                else {
                    if(names.count > 1) {
                    break;
                } else {
                    names = []
                    code = ""
                }
                }
            }
        }
        var index = names.count
       
        while (index < 4) {
            index += 1
            names.append("" + "," + "" + "," + "" + "," + "" + "," + "")
        }
        
      
        return names
    }
    
    
    
    //MARK:Constraints
    
    func checkConstraints() {
        if((distributiveCoursesDataTrack.count) == 0) {
            distance.constant = 20.0
        } else {
          distance.constant = 10.0
        }
    }
    
    
    //MARK: Animations

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      
        let toViewController = segue.destination as UIViewController
        transition.openingView = CGRect(x: 0,y: 75,width: self.view.frame.size.width,height: 150)
        toViewController.modalPresentationStyle = .custom
        toViewController.transitioningDelegate = self.transition
        
    }

    }

