//
//  GpaControler.swift
//  Audit
//
//  Created by Raghav Bhasin on 6/13/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit
import JBChart
import pop

class GpaControler: UIViewController,JBBarChartViewDelegate,JBBarChartViewDataSource, UIViewControllerTransitioningDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var GPAInfo: UIImageView!
    @IBOutlet weak var noteLabel: UILabel!
    
    @IBOutlet weak var qpLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var alingnController: NSLayoutConstraint!
    
    @IBOutlet weak var courseView: UIView!
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var noCourses: UILabel!
    @IBOutlet weak var EmptyView: UIView!
    @IBOutlet weak var descNoCourse: UILabel!
    @IBOutlet weak var pic: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var gpaLabel: UILabel!
    
    
    @IBOutlet weak var gpaBar: JBBarChartView!
    
    
    @IBOutlet weak var navigationBar: UINavigationBar!

    
    
  
     let transition = slideTransition(style: .slideRight)
    
   
    var stateClose = false
    var data: [Course] = []
    var chartData: [Double] = []
 

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButton()
        // Do any additional setup after loading the view, typically from a nib.
        
           if(!shouldNotLoad()) {
            chartData.append(calcGpa())
       
        
        gpaBar.backgroundColor = UIColor.lightGray
        gpaBar.delegate = self
        gpaBar.dataSource = self
        gpaBar.maximumValue = 4.0
        gpaBar.minimumValue = 0.0
        gpaBar.setState(.collapsed, animated: false)
        gpaLabel.text = ""
        textField.text = String(dataSet.numberOfCredits)
        gpaBar.transform = CGAffineTransform(rotationAngle: (250 * CGFloat(M_PI)) / 100)
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(GpaControler.showChart), userInfo: nil, repeats: false)
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(netHex:0x040AA4),NSFontAttributeName: UIFont(name: "ChalkboardSE-Bold", size: 19.0)!]
        self.gpaBar.reloadData()
        gpaBar.layer.cornerRadius = 3.0
        gpaBar.alpha = 1.0
        gpaBar.clipsToBounds = true
        gpaBar.barView(at: UInt(0)).layer.cornerRadius = gpaBar.layer.cornerRadius
        gpaBar.barView(at: UInt(0)).clipsToBounds = true
        gpaLabel.text =  "GPA is \((NSString(format: "%.3f",chartData[0]) as String))/4.000"
        EmptyView!.alpha = 0.0
        status()
        note()
        GPAInfo.layer.cornerRadius = 4.0
        GPAInfo.clipsToBounds = true
    } else {
             EmptyView!.alpha = 1.0
             noCourses.alpha = 1.0
             descNoCourse.alpha = 1.0
             pic.alpha = 1.0
            
            noCourses.font = UIFont.boldSystemFont(ofSize: 22.0)
            descNoCourse.font = UIFont.systemFont(ofSize: 14.0)
            
            navItem.rightBarButtonItem?.isEnabled = false
            navItem.rightBarButtonItem?.customView?.alpha = 0.3
            
        }
        
    }
    let MARK = 5.0
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        hideChart()
    }
    
    func hideChart() {
        self.gpaBar.setState(.collapsed, animated: true)
    }
    func calcGpa() -> Double{
      
        
        var actualCredits = 0
        var qualityPoint = 0.0
        for courses in dataSet.courses {
            if (returnQp(courses.gradeEarned) != MARK && courses.term != "AP") {
                actualCredits += courses.credit
                qualityPoint += Double(courses.credit) * returnQp(courses.gradeEarned)
                data.append(courses)

            }
            

        }
        qpLabel.text = "Quality Points: " + String(NSString(format: "%0.2f",qualityPoint))
        if (qualityPoint == 0) {
            return 0.0
        } else {
        
        return qualityPoint/Double(actualCredits)
        }
    }
    
    func returnQp(_ grade :String) -> Double {
        
        if (grade == "A+" || grade == "A") {
            return 4.0
        }
        else if (grade == "A-") {
            return 3.7
        }
        else if (grade == "B+") {
            return 3.3
        }
        else if (grade == "B") {
            return 3.0
        }
        else if (grade == "B-") {
            return 2.7
        }
        else if (grade == "C+") {
            return 2.3
        }
        else if (grade == "C") {
            return 2.0
        }
        else if (grade == "C-") {
            return 1.7
        }
        else if (grade == "D") {
            return 1.0
        }
        else if (grade == "P") {
            return MARK
        }
        else {
            return 0.0
        }
    }
    
    func showChart() {
        
        let delayTime = DispatchTime.now() + Double(Int64(0.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.gpaBar.setState(.expanded, animated: true)

        }
        

          }
    
    func numberOfBars(in barChartView: JBBarChartView!) -> UInt {
        return UInt(chartData.count);
    }
    
    func barChartView(_ barChartView: JBBarChartView!, heightForBarViewAt index: UInt) -> CGFloat {
        return CGFloat(chartData[Int(index)])
    }
    
    func barChartView(_ barChartView: JBBarChartView!, colorForBarViewAt index: UInt) -> UIColor! {
        if (chartData[Int(0)] >= 2.0) {
            return Green
        }
        else {
       return Red
        }
    }
    func barChartView(_ barChartView: JBBarChartView!, didSelectBarAt index: UInt) {
  
        gpaLabelAnim()
       
    }
    func didDeselect(_ barChartView: JBBarChartView!) {
       
        gpaLabelDeAnim()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let toViewController = segue.destination as UIViewController
        
        toViewController.modalPresentationStyle = .custom
        toViewController.transitioningDelegate = self.transition
        
    }
    
    
    
    func shouldNotLoad() ->Bool {
        
        return dataSet.courses.count == 0
    }
    
    
    func addBarButton() {
        
        let button: PaperButton = PaperButton(frame: CGRect(x: self.view.frame.origin.x,
           y: self.view.frame.origin.y,
            width: 24,
            height: 17))
        button.addTarget(self, action: #selector(GpaControler.animate), for: .touchUpInside)
        button.tintColor = UIColor.black
        let barButton = UIBarButtonItem(customView: button)
        
        self.navItem.rightBarButtonItem = barButton
        
           }
  
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
   let course = data[indexPath.row]
        tableView.separatorStyle = .none
        let identifier = "GPACoursesCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! GPACoursesTableViewCell
        
        
        cell.name.font = UIFont(name: "HelveticaNeue-Medium", size: 11.3)
        cell.GPA.font = UIFont(name: "HelveticaNeue-Medium", size: 11.3)
        cell.QP.font = UIFont(name: "HelveticaNeue-Medium", size: 11.3)
        cell.name.text = course.name
        cell.GPA.text = "GPA: " + String(NSString(format:"%0.2f",self.returnQp(course.gradeEarned)))
        
        let qualityPoints = self.returnQp(course.gradeEarned) * Double(course.credit)
        cell.QP.text = "Quality Points: " + String(NSString(format:"%0.2f",qualityPoints))
        
        return cell
    }
 

  
    func animate() {
        let outView = self.view.resizableSnapshotView(from: CGRect(x: 0,y: 70,width: self.view.frame.size.width,height: self.view.frame.size.height), afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)
        outView!.frame = CGRect(x: 0,y: 70,width: self.view.frame.size.width,height: self.view.frame.size.height)
        let m = UIView(frame: outView!.frame)
        m.backgroundColor = UIColor.white
        self.view.addSubview(m)
        self.view.addSubview(outView!)
        UIView.animate(withDuration: 0.2, animations: {
            outView!.frame = CGRect(x: -self.view.frame.size.width,y: 70,width: self.view.frame.size.width,height: self.view.frame.size.height)
            

            }, completion: { (finished) in
                m.removeFromSuperview()
                outView!.removeFromSuperview()
                self.possitionTable()
                if(self.stateClose) {
                    self.courseView.alpha = 0.0
                } else {
                    self.courseView.alpha = 1.0
                }
                
                self.stateClose = !self.stateClose

        }) 
        
        
    
    }
    

 
 
    func possitionTable() {
        let wasteHeight:CGFloat = 96.0
		
        let ocuupiedHeeight = 44.0 * CGFloat(13)
        let heightLeft = self.view.frame.size.height - ocuupiedHeeight - wasteHeight
        alingnController.constant = heightLeft / 2
        
        
    }
    
    
    
    
    func gpaLabelAnim() {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        
        scaleAnim?.toValue = NSValue(cgPoint: CGPoint(x: 1 ,y: 1))
        scaleAnim?.velocity = NSValue(cgPoint: CGPoint(x: 20,y: 20))
        scaleAnim?.springBounciness = 20.0
        self.gpaLabel.pop_add(scaleAnim, forKey: "scaleAnimation")
    }
    
    
    func gpaLabelDeAnim() {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
        
        scaleAnim?.toValue = NSValue(cgPoint: CGPoint(x: 1,y: 1))
        scaleAnim?.velocity = NSValue(cgPoint: CGPoint(x: 1,y: 1))
        scaleAnim?.springBounciness = 20.0
        self.gpaLabel.pop_add(scaleAnim, forKey: "scaleAnimation")
    }
    
    func status() {
        if(dataSet.numberOfCredits < 30) {
           statusLabel.text = "Status: FRESHMAN"
        } else if(dataSet.numberOfCredits >= 30 && dataSet.numberOfCredits < 60) {
            statusLabel.text = "Status: SOPHOMORE"
        } else if(dataSet.numberOfCredits >= 60 && dataSet.numberOfCredits < 90) {
            statusLabel.text = "Status: JUNIOR"
        } else {
            statusLabel.text = "Status: SENIOR"

        }
    }
    
    
    func note() {
        let gpa = chartData[0]
        
        
        
        if(gpa == 4.0) {
              noteLabel.text = "bhup! Sala bloody 4 pointer"
        }
        
        
        else if(gpa > 3.5) {
           noteLabel.text = "You have been awarded Academic Honors."
        } else if(gpa > 3.4 && gpa < 3.5) {
            noteLabel.text = "Congratulations! You have successfully pulled off a Jeremy."

        } else {
            noteLabel.text = ""
        }
    }
    }
