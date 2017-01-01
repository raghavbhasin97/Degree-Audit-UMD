//
//  FirstViewController.swift
//  test
//
//  Created by Raghav Bhasin on 6/12/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit
import Darwin

class FirstViewController: UIViewController, PiechartDelegate, UIPopoverPresentationControllerDelegate, UIViewControllerTransitioningDelegate{
    
    let transition = slideTransition(style: .slideLeft)

 

    var background:UIImage = UIImage()
    var imageView: UIImageView! = nil
    
    @IBOutlet weak var profilePic: UIImageView!

    @IBOutlet weak var uidLabel: UILabel!
    
       @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var majorLabel: UILabel!
    
    var selectedButton: UIButton!
    var color : UIColor!

    var piechart: Piechart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
       setStatusBarBackgroundColor(UIColor(netHex: 0xF8F8F8))        
       
        // Do any additional setup after loading the view, typically from a nib
     
        
       
        
     
    
        if !UserDefaults.standard.bool(forKey: "launchedBefore") {
	
            self.view.backgroundColor = UIColor.clear
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.extraLight))
             blurView.frame = self.view.bounds
            self.view.addSubview(blurView)
            createAlert()
        }
        else {
            if let coursesL = loadCourses() {
                dataSet.courses = coursesL.courses
                dataSet.numberOfCredits = coursesL.numberOfCredits
                
            }
            dataSet.sort()
            
            let data = loadUser()
            User.FirstName = data?.FirstName
            User.lastName = data?.lastName
            User.email = data?.email
            User.MAJOR = data?.MAJOR
            User.UID = (data?.UID)!
            User.photo = data?.photo
            profilePic.image = User.photo
            profilePic.layer.borderWidth = 1.0
            profilePic.layer.borderColor = UIColor.white.cgColor
            nameLabel.text = (User.FirstName + " " + User.lastName)
            profilePic.layer.cornerRadius = 10.0
            profilePic.clipsToBounds = true
            uidLabel.text = String(User.UID)
            majorLabel.text = User.MAJOR
            
            let degreeData = loadDegrees()
            degreesData.degrees = (degreeData?.degrees)!
            
            let tapGesture = UITapGestureRecognizer(target: self, action:#selector(FirstViewController.tapGesture(_:)))
            profilePic.addGestureRecognizer(tapGesture)
            profilePic.isUserInteractionEnabled = true
            
            var views: [String: UIView] = [:]
            
            var currentCredits = Piechart.Slice()
            currentCredits.value = CGFloat(dataSet.numberOfCredits)
            currentCredits.color = Green
            currentCredits.text = "Satisfied"
            currentCredits.alpha = 0.8
            
            var totalCredits = Piechart.Slice()
            totalCredits.value = 120 - CGFloat(dataSet.numberOfCredits)
            totalCredits.color = Red
            totalCredits.text = "Unsatisfied"
            totalCredits.alpha = 0.8
            
            
            
            piechart = Piechart()
            piechart.delegate = self
            piechart.title = "Credits"
            piechart.activeSlice = 0
            piechart.layer.borderWidth = 1
            piechart.slices = [currentCredits, totalCredits]
            
            piechart.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(piechart)
            views["piechart"] = piechart
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[piechart]-|", options: [], metrics: nil, views: views))
            
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-150-[piechart(==200)]", options: [], metrics: nil, views: views))
            

        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    

  
 
    
    func loadCourses() -> CorseManager? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: CorseManager.ArchiveURL.path) as? CorseManager
    }
    
    func saveCourses() {
       NSKeyedArchiver.archiveRootObject(dataSet, toFile: CorseManager.ArchiveURL.path)
        
    }
    
    func loadUser() -> Person? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Person.ArchiveURL.path) as? Person
    }
  
    func loadDegrees() -> DegreeManager? {
         return NSKeyedUnarchiver.unarchiveObject(withFile: DegreeManager.ArchiveURL.path) as? DegreeManager
    }
    
    func createAlert() {
		
		let seconds = 0.0
		let delay = seconds * Double(NSEC_PER_SEC)
		let dispatchTime = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
		
		
		DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
			
			self.firstLoginScreen()
		}
		

    }
    func firstLoginScreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let vc : UIViewController = storyBoard.instantiateViewController(withIdentifier: "newUser")
        
        self.present(vc, animated: false, completion: nil)
        
    }
    
    func setSubtitle(_ total: CGFloat, slice: Piechart.Slice) -> String {
        let percentage = NSString(format: "%.2f",(slice.value / total * 100))
        return "\(percentage)% \(slice.text)"
    }
    
    func setInfo(_ total: CGFloat, slice: Piechart.Slice) -> String {
        return "\(Int(slice.value))/\(Int(total))"
    }

    
    func tapGesture(_ gesture: UIGestureRecognizer) {

        backgroungSet()
     
        let storyboard : UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        let popOver:UIViewController = storyboard.instantiateViewController(withIdentifier: "popUp")
        
        popOver.modalPresentationStyle = .popover
        popOver.preferredContentSize = CGSize(width: 400, height: 400)

        
        let popoverMenuViewController = popOver.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = self.view
        popoverMenuViewController?.sourceRect = CGRect(x: profilePic.frame.origin.x + 25, y: profilePic.frame.origin.y+40, width: 1,height: 1)
        
         present(popOver,animated: true,completion: nil)
        
        
       
    }
    
    func adaptivePresentationStyle(
        for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
 
    
    
    func backgroungSet() {
    
        
        background = UIImage(named: "ScreenShot")!

        
        
        imageView = UIImageView(image: background)
        
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        imageView.alpha = 0.92

        self.view.addSubview(imageView)

    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        imageView.alpha = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "reqs") {
    
            for v in self.view.subviews as [UIView] {
                v.removeFromSuperview()
            }
            
        }
        let toViewController = segue.destination as UIViewController
        
         toViewController.modalPresentationStyle = .custom
         toViewController.transitioningDelegate = self.transition
        
    }
    
    func setStatusBarBackgroundColor(_ color: UIColor)
    {
        guard  let statusBar = (UIApplication.shared.value(forKey: "statusBarWindow") as AnyObject).value(forKey: "statusBar") as? UIView
            else
        {
            return
        }
        statusBar.backgroundColor = color
    }

  
 }
