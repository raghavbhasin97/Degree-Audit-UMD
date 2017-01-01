//
//  genEd.swift
//  Audit
//
//  Created by Raghav Bhasin on 6/24/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit

class genEd: UIViewController, UITableViewDataSource, UITableViewDelegate ,UIViewControllerTransitioningDelegate{
       let transition = cellDetailDeanimator()
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!


    @IBOutlet weak var chartHolder: UIView!
  
    @IBOutlet weak var fundamentals: UITableView!
    
    @IBOutlet weak var distributives: UITableView!
    @IBOutlet weak var iSeries: UITableView!
   
    @IBOutlet weak var diversity: UITableView!
    var iSeriesArrDesc = ["I-Series (SCIS)"]
    var diversityArrDesc = ["Understanding Plural Society (DVUP)", "Cultural Competency (DVCC)"]
    var distributiveArrDesc = ["Humanities (DSHU)","History & Social Science (DSHS)","Natural Sciences with Lab (DSNL)","Natural Sciences (DSNS or DSNL)","Scholarship in Practice (DSSP)"]
    var iseriesOne: String!
    var diversityOne: String!
    var dshuOne: String!
    var dshsOne: String!
    var dsspOne: String!
    var dsnsnlOne: String!
    var fundamentalsArrDesc = ["Academic Writing (FSAW)", "Professional Writing (FSPW)","Oral Communication (FSOC)","Math (FSMA)","Analytic Reasoning (FSAR)"]
      override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes
            = [NSForegroundColorAttributeName: UIColor.blue.withAlphaComponent(0.6),
               NSFontAttributeName: UIFont(name: "Marker Felt", size: 18)!]
        
        
        
        let circleChart = PNCircleChart(frame: CGRect(x: 120,y: 0, width: 20, height: 100.0), total: NSNumber(value: 100 as Int), current: NSNumber(value: 2 as Int), clockwise: false, shadow: true, shadowColor: UIColor.lightGray.withAlphaComponent(0.67), displayCountingLabel: true, overrideLineWidth: NSNumber(value: 8 as Int))
        
        
        circleChart?.backgroundColor = UIColor.clear
        circleChart?.strokeColor = UIColor.blue
        circleChart?.displayAnimated = false
        circleChart?.stroke()
        
        
        circleChart?.backgroundColor = UIColor.clear
        let num = dataSet.returnGCreditsPercent()
        circleChart?.update(byCurrent: NSNumber(value: num as Int))
        
    
        chartHolder.addSubview(circleChart!)
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
      
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == fundamentals) {
        return fundamentalsArrDesc.count
        } else if (tableView == iSeries) {
            return iSeriesArrDesc.count
        } else if (tableView == diversity) {
            return diversityArrDesc.count
        }else if(tableView == distributives){
            return distributiveArrDesc.count
        }
      else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      if(tableView == fundamentals) {
        let cellIdentifier = "degreeTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! degreeTableViewCell
        
        
        cell.classification.text = fundamentalsArrDesc[indexPath.row]
        cell.classification?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        cell.grade?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.name?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.credits?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
        cell.desc?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.name.text = ""
            cell.credits.text = ""
            cell.grade.text = ""
            cell.desc.text = ""
        
        if(indexPath.row == 0) {
            let str = FSAW()
            if(str == "") {
                cell.name!.text? = "Needs 1 course in Academic writing"
                cell.name.textColor = UIColor.blue
            } else {

                let data = str.components(separatedBy: ",")
                 cell.name.text = data[Int(0)]
                
                 cell.credits.text = String(NSString(format: "%.2f",Double(data[2])!))
                if(data[3] == "AP") {
                     cell.desc.text = "ADVANCED PLACEMENT"
                    cell.grade.text = "T" + data[Int(1)]
                } else {
                    cell.grade.text = data[Int(1)]
                 cell.desc.text = data[4]
                }
            }
        } else if(indexPath.row == 1) {
            let str = FSPW()
            if(str == "") {
                cell.name!.text? = "Needs 1 course in Professional writing"
                 cell.name.textColor = UIColor.blue
            } else {
                let data = str.components(separatedBy: ",")
                cell.name.text = data[Int(0)]
                cell.grade.text = data[Int(1)]
                cell.credits.text = String(NSString(format: "%.2f",Double(data[2])!))
                if(data[3] == "AP") {
                    cell.desc.text = "ADVANCED PLACEMENT"
                    cell.grade.text = "T" + data[Int(1)]
                } else {
                cell.desc.text = data[4]
                }
            }

        } else if(indexPath.row == 2) {
            let str = FSOC()
            if(str == "") {
                cell.name!.text? = "Needs 1 course in Oral Communication"
                 cell.name.textColor = UIColor.blue
            } else {
                let data = str.components(separatedBy: ",")
                cell.name.text = data[Int(0)]
                cell.grade.text = data[Int(1)]
                cell.credits.text = String(NSString(format: "%.2f",Double(data[2])!))
                if(data[3] == "AP") {
                    cell.desc.text = "ADVANCED PLACEMENT"
                    cell.grade.text = "T" + data[Int(1)]
                } else {
                 cell.desc.text = data[4]
                }

            }
        } else if(indexPath.row == 3) {
            let str = FSMA()
            if(str == "") {
                cell.name!.text? = "Needs 1 course in Math(MATH140)"
                 cell.name.textColor = UIColor.blue
            } else {
                let data = str.components(separatedBy: ",")
                cell.name.text = data[Int(0)]
                cell.grade.text = data[Int(1)]
                cell.credits.text = String(NSString(format: "%.2f",Double(data[2])!))
                if(data[3] == "AP") {
                    cell.desc.text = "ADVANCED PLACEMENT"
                    cell.grade.text = "T" + data[Int(1)]
                } else {
                cell.desc.text = data[4]
                }
            }

        } else if(indexPath.row == 4) {
            let str = FSAR()
            if(str == "") {
                cell.name!.text? = "Needs 1 course in Analytical Reasoning"
				cell.name.textColor = UIColor.blue
            } else {
                let data = str.components(separatedBy: ",")
                cell.name.text = data[Int(0)]
                cell.grade.text = data[Int(1)]
                cell.credits.text = String(NSString(format: "%.2f",Double(data[2])!))
                if(data[3] == "AP") {
                    cell.desc.text = "ADVANCED PLACEMENT"
                    cell.grade.text = "T" + data[Int(1)]
                } else {
                cell.desc.text = data[4]
                }
            }
        }




        return cell
        }  else if (tableView == iSeries){
    
            let cellIdentifier = "degreeTwoTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! degreeTwoTableViewCell
            cell.classification.text = iSeriesArrDesc[indexPath.row]
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
            let str1 = SCIS()
            let str2 = SCIS()

            if(str1 == "") {
                cell.name1.text = "Needs 2 courses in SCIS"
                 cell.name1.textColor = UIColor.blue
                 iSeries.rowHeight = 50.0
                 iSeries.frame.size.height = 50.0
            } else {
                iSeries.rowHeight = 80.0
             
                let data = str1.components(separatedBy: ",")
                cell.name1.text = data[Int(0)]
                cell.grade1.text = data[Int(1)]
                cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                cell.desc1.text = data[4]
              
                if(str2 == "" ) {
                    cell.name2.text = "Needs 1 course in SCIS"
                     cell.name2.textColor = UIColor.blue
                } else {
                    let data = str2.components(separatedBy: ",")
                    cell.name2.text = data[Int(0)]
                    cell.grade2.text = data[Int(1)]
                    cell.credit2.text = String(NSString(format: "%.2f",Double(data[2])!))
                    cell.desc2.text = data[4]
                    
                }
            }
            
            
            
            return cell
        }
        else if(tableView == diversity){
            let cellIdentifier = "degreeTableViewCellThree"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! degreeTableViewCell
            
            
            cell.classification.text = diversityArrDesc[indexPath.row]
            cell.classification?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
            cell.grade?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.name?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.credits?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.desc?.font = UIFont(name: "HelveticaNeue-Light", size: 10)
            cell.name.text = ""
            cell.credits.text = ""
            cell.grade.text = ""
            cell.desc.text = ""
            
            if(indexPath.row == 0) {
                let str = DVUP()
                if(str == "") {
                    cell.name!.text? = "Needs 1 course in DVUP"
                     cell.name.textColor = UIColor.blue
                } else {
                    let data = str.components(separatedBy: ",")
                    cell.name.text = data[Int(0)]
                    
                    cell.credits.text = String(NSString(format: "%.2f",Double(data[2])!))
                    if(data[3] == "AP") {
                        cell.desc.text = "ADVANCED PLACEMENT"
                        cell.grade.text = "T" + data[Int(1)]
                    } else {
                        cell.grade.text = data[Int(1)]
                        cell.desc.text = data[4]
                    }
                }

            }
           
            else {
               let str = DVUP_DVCC()
                if(str == "") {
                    cell.name!.text? = "Needs 1 course in DVUP or DVCC"
                     cell.name.textColor = UIColor.blue
                } else {
                    let data = str.components(separatedBy: ",")
                    cell.name.text = data[Int(0)]
                    
                    cell.credits.text = String(NSString(format: "%.2f",Double(data[2])!))
                    if(data[3] == "AP") {
                        cell.desc.text = "ADVANCED PLACEMENT"
                        cell.grade.text = "T" + data[Int(1)]
                    } else {
                        cell.grade.text = data[Int(1)]
                        cell.desc.text = data[4]
                    }
                }

            }
            return cell
        } else {

            
            let cellIdentifier = "degreeFourTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! degreeTwoTableViewCell
            cell.classification.text = distributiveArrDesc[indexPath.row]
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
        
            if(indexPath.row == 0) {
                let str1 = DSHU()
                let str2 = DSHU()
                
                if(str1 == "") {
                     cell.name1.text = "Needs 2 courses in DSHU"
                     cell.name1.textColor = UIColor.blue
                     distributives.rowHeight = 50.0
                     distributives.frame.size.height -= 40.0
                } else {
                    distributives.rowHeight = 80.0
                    let data = str1.components(separatedBy: ",")
                    cell.name1.text = data[Int(0)]
                    cell.grade1.text = data[Int(1)]
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    if(data[3] == "AP") {
                        cell.desc1.text = "ADVANCED PLACEMENT"
                        cell.grade1.text = "T" + data[Int(1)]
                    } else {
                        cell.grade1.text = data[Int(1)]
                        cell.desc1.text = data[4]
                    }
                    
                    if(str2 == "" ) {
                        cell.name2.text = "Needs 1 course in DSHU"
                         cell.name2.textColor = UIColor.blue
                    } else {
                        let data = str2.components(separatedBy: ",")
                        cell.name2.text = data[Int(0)]
                        cell.grade2.text = data[Int(1)]
                        cell.credit2.text = String(NSString(format: "%.2f",Double(data[2])!))
                        if(data[3] == "AP") {
                            cell.desc2.text = "ADVANCED PLACEMENT"
                            cell.grade2.text = "T" + data[Int(1)]
                        } else {
                            cell.grade2.text = data[Int(1)]
                            cell.desc2.text = data[4]
                        }

                    }
                }
                
            }
            
            else if(indexPath.row == 1) {
                let str1 = DSHS()
                let str2 = DSHS()
                
                if(str1 == "") {
                    cell.name1.text = "Needs 2 courses in DSHS"
                     cell.name1.textColor = UIColor.blue
                    distributives.rowHeight = 50.0
                    distributives.frame.size.height -= 40.0
                } else {
                    distributives.rowHeight = 80.0
                    let data = str1.components(separatedBy: ",")
                    cell.name1.text = data[Int(0)]
                    cell.grade1.text = data[Int(1)]
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    cell.desc1.text = data[4]
                    if(data[3] == "AP") {
                        cell.desc1.text = "ADVANCED PLACEMENT"
                        cell.grade1.text = "T" + data[Int(1)]
                    } else {
                        cell.grade1.text = data[Int(1)]
                        cell.desc1.text = data[4]
                    }
                    
                    if(str2 == "" ) {
                        cell.name2.text = "Needs 1 course in DSHS"
                         cell.name2.textColor = UIColor.blue
                    } else {
                        let data = str2.components(separatedBy: ",")
                        cell.name2.text = data[Int(0)]
                        cell.grade2.text = data[Int(1)]
                        cell.credit2.text = String(NSString(format: "%.2f",Double(data[2])!))
    
                        if(data[3] == "AP") {
                            cell.desc2.text = "ADVANCED PLACEMENT"
                            cell.grade2.text = "T" + data[Int(1)]
                        } else {
                            cell.grade2.text = data[Int(1)]
                            cell.desc2.text = data[4]
                        }

                        
                    }
                }

            }
            
            else if (indexPath.row == 2) {
                distributives.rowHeight = 50.0
                let str1 = DSNL()

                
                if(str1 == "") {
                    cell.name1.text = "Needs 1 courses in DSNL"
                     cell.name1.textColor = UIColor.blue
                } else {
                    let data = str1.components(separatedBy: ",")
                    cell.name1.text = data[Int(0)]
                    cell.grade1.text = data[Int(1)]
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    if(data[3] == "AP") {
                        cell.desc1.text = "ADVANCED PLACEMENT"
                        cell.grade1.text = "T" + data[Int(1)]
                    } else {
                        cell.grade1.text = data[Int(1)]
                        cell.desc1.text = data[4]
                    }

                    
        }

            }
            
            else if(indexPath.row == 3) {
                
                let str1 = DSNL_DSNS()
                
                
                if(str1 == "") {
                    cell.name1.text = "Needs 1 courses in DSNS or DSNL"
                     cell.name1.textColor = UIColor.blue
                } else {
                    let data = str1.components(separatedBy: ",")
                    cell.name1.text = data[Int(0)]
                    cell.grade1.text = data[Int(1)]
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    if(data[3] == "AP") {
                        cell.desc1.text = "ADVANCED PLACEMENT"
                        cell.grade1.text = "T" + data[Int(1)]
                    } else {
                        cell.grade1.text = data[Int(1)]
                        cell.desc1.text = data[4]
                    }
                    
                    
                }
                

                
            } else {
                let str1 = DSSP()
                let str2 = DSSP()
                
                if(str1 == "") {
                    cell.name1.text = "Needs 2 courses in DSSP"
                     cell.name1.textColor = UIColor.blue
                    distributives.rowHeight = 50.0
                    distributives.frame.size.height -= 40.0
                } else {
                    distributives.rowHeight = 80.0
                    let data = str1.components(separatedBy: ",")
                    cell.name1.text = data[Int(0)]
                    cell.grade1.text = data[Int(1)]
                    cell.credit1.text = String(NSString(format: "%.2f",Double(data[2])!))
                    cell.desc1.text = data[4]
                    
                    if(str2 == "" ) {
                        cell.name2.text = "Needs 1 course in DSSP"
                         cell.name2.textColor = UIColor.blue
                        
                    } else {
                        let data = str2.components(separatedBy: ",")
                        cell.name2.text = data[Int(0)]
                        cell.grade2.text = data[Int(1)]
                        cell.credit2.text = String(NSString(format: "%.2f",Double(data[2])!))
                        cell.desc2.text = data[4]
                        
                        
                    }
                }

                
                
            }
            return cell
        }
    }

    
    func FSAW() -> String {

        for course in dataSet.courses {
            let data = course.requirements.components(separatedBy: ",")
            if(data.contains("FSAW")) {
                return (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," +
                course.term + "," + course.desc)
            }
          
        }
        
        return ""
    }
    
    func FSPW() -> String {
        
        for course in dataSet.courses {
            let data = course.requirements.components(separatedBy: ",")
            if(data.contains("FSPW")) {
              
                return (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," +
                    course.term + "," + course.desc)
            }
            
        }
        
        return ""
    }
    
    func FSOC() -> String {
        
        for course in dataSet.courses {
            let data = course.requirements.components(separatedBy: ",")
            if(data.contains("FSOC")) {
              
                return (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," +
                    course.term + "," + course.desc)
            }
            
        }
        
        return ""
    }
    
    func FSMA() -> String {
        
        for course in dataSet.courses {
            let data = course.requirements.components(separatedBy: ",")
            if(data.contains("FSMA")) {
              
                return (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," +
                    course.term + "," + course.desc)
            }
            
        }
        
        return ""
    }
    
    func FSAR() -> String {
        
        for course in dataSet.courses {
            let data = course.requirements.components(separatedBy: ",")
            if(data.contains("FSAR")) {
             
                return (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," +
                    course.term + "," + course.desc)
            }
            
        }
        
        return ""
    }
    
    func SCIS() -> String {
        
        for course in dataSet.courses {
            let data = course.requirements.components(separatedBy: ",")
            if(data.contains("SCIS")) {
                if(course.name != iseriesOne) {
                    iseriesOne = course.name
                  
                    return (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," +
                        course.term + "," + course.desc)
                }
            }
            
        }
        
        return ""
    }
    
    func DVUP() -> String {
        
        for course in dataSet.courses {
            let data = course.requirements.components(separatedBy: ",")
            if(data.contains("DVUP")) {
                diversityOne = course.name
              
                                  return (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," +
                        course.term + "," + course.desc)
                
            }
            
        }
        
        return ""
    }
    func DVUP_DVCC() -> String {
        
        for course in dataSet.courses {
            let data = course.requirements.components(separatedBy: ",")
            if(data.contains("DVUP") || data.contains("DVCC")) {
                if(course.name != diversityOne) {
                    diversityOne = course.name
               
                    return (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," +
                        course.term + "," + course.desc)
                }
            }
            
        }
        
        return ""
    }
    
    func DSHU() -> String {
        
        for course in dataSet.courses {
            let data = course.requirements.components(separatedBy: ",")
            if(data.contains("DSHU")) {
                if(course.name != dshuOne) {
                    dshuOne = course.name
                    
                    return (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," +
                        course.term + "," + course.desc)
                }
            }
            
        }
        
        return ""
    }
    
    func DSHS() -> String {
        
        for course in dataSet.courses {
            let data = course.requirements.components(separatedBy: ",")
            if(data.contains("DSHS")) {
                if(course.name != dshsOne) {
                    dshsOne = course.name
                   
                    return (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," +
                        course.term + "," + course.desc)
                }
            }
            
        }
        
        return ""
    }


    func DSSP() -> String {
        
        for course in dataSet.courses {
            let data = course.requirements.components(separatedBy: ",")
            if(data.contains("DSSP")) {
                if(course.name != dsspOne) {
                    dsspOne = course.name
                  
                    return (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," +
                        course.term + "," + course.desc)
                }
            }
            
        }
        
        return ""
    }

    func DSNL() -> String {
        
        for course in dataSet.courses {
            let data = course.requirements.components(separatedBy: ",")
            if(data.contains("DSNL")) {
                    dsnsnlOne = course.name
                
                    return (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," +
                        course.term + "," + course.desc)
            }
            
        }
        
        return ""
    }

    func DSNL_DSNS() -> String {
        
        for course in dataSet.courses {
            let data = course.requirements.components(separatedBy: ",")
            if(data.contains("DSNL") || data.contains("DSNS")) {
                if(course.name != dsnsnlOne) {
                dsnsnlOne = course.name
                   
                return (course.name + "," + course.gradeEarned + "," + String(course.credit) + "," +
                    course.term + "," + course.desc)
                }
            }
            
        }
        
        return ""
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		
        let toViewController = segue.destination as UIViewController
        transition.openingView = CGRect(x: 0,y: 75,width: self.view.frame.size.width,height: 150)
        toViewController.modalPresentationStyle = .custom
        toViewController.transitioningDelegate = self.transition
        
    }
   }
