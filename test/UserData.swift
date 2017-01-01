//
//  UserData.swift
//  Audit
//
//  Created by Raghav Bhasin on 6/19/16.
//  Copyright © 2016 Test Apps. All rights reserved.
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


class UserData: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MYIntroductionDelegate{
    
    
    @IBOutlet weak var fName: UITextField!

    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var uid: UITextField?
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var imageView: UIImageView!
	
    var picker:UIImagePickerController? = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
				self.buildIntro()
	
	
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(UserData.tapGesture(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
        picker?.delegate = self
        
        major.text! = "Computer Science"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
}
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == fName) {
            fName.resignFirstResponder()
            lName.becomeFirstResponder()
        } else if (textField == lName) {
            lName.resignFirstResponder()
            email.becomeFirstResponder()
        } else if (textField == email) {
            email.resignFirstResponder()
             uid?.becomeFirstResponder()
        } else if(textField == uid) {
            
            if(uid?.text?.characters.count < 9) {
                uid?.text = ""
            }
            else {
            textField.resignFirstResponder()
            }
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    @IBAction func saveData(_ sender: UIButton) {
        
        if(fName.text == "" || lName.text == "" || email.text == "" || uid?.text == "" || major.text == "") {
            let alert = UIAlertController(title: "Missing Information", message: "All fields are required.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        else if(self.isDefaultImage(imageView.image!)) {
            let alert = UIAlertController(title: "Missing Profile Picture", message: "A Profile Picture is required.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }

        else {
        User.add(fName.text!, lastName: lName.text!, UID: Int64((uid?.text!)!)!, email: email.text!, MAJOR: major.text!, photo: imageView.image!)
		NSKeyedArchiver.archiveRootObject(User, toFile: Person.ArchiveURL.path)

        UserDefaults.standard.set(true, forKey: "launchedBefore")

        
        degreesData.addProgram("GENED", field: "General Education")
        degreesData.addProgram("MAJOR", field: User.MAJOR)
        NSKeyedArchiver.archiveRootObject(degreesData, toFile: DegreeManager.ArchiveURL.path)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let vc : UITabBarController = storyBoard.instantiateViewController(withIdentifier: "mainWindow") as!
            UITabBarController
        
        self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        let length = (textField.text?.characters.count)! + string.characters.count
        
        if (textField == fName || textField == lName || textField == major) {
            if(
    string == "A" || string == "B" || string == "C" || string == "D" || string == "E" || string == "F" ||
    string == "G" || string == "H" || string == "I" || string == "J" || string == "K" || string == "L" ||
    string == "M" || string == "N" || string == "O" || string == "P" || string  == "Q" || string == "R" ||
    string == "S" || string == "T" || string == "U" || string == "V" || string == "W" || string == "X" ||
    string == "Y" || string == "Z" || string == "a" || string == "b" || string == "c" || string == "d" ||
    string == "e" || string == "f" || string == "g" || string == "h" || string == "i" || string == "j" ||
    string == "k" || string == "l" || string == "m" || string == "n" || string == "o" || string == "p" ||
    string  == "q" || string == "r" || string == "s" || string == "t" || string == "u" || string == "v" ||
    string == "w" || string == "x" || string == "y" || string == "z" || string == " " || isBackSpace == -92 )
            
            {
                return true
            } else {
                return false
            }
            
        }
        else if(textField == email) {
            if(
    string == "A" || string == "B" || string == "C" || string == "D" || string == "E" || string == "F" ||
    string == "G" || string == "H" || string == "I" || string == "J" || string == "K" || string == "L" ||
    string == "M" || string == "N" || string == "O" || string == "P" || string  == "Q" || string == "R" ||
    string == "S" || string == "T" || string == "U" || string == "V" || string == "W" || string == "X" ||
    string == "Y" || string == "Z" || string == "a" || string == "b" || string == "c" || string == "d" ||
    string == "e" || string == "f" || string == "g" || string == "h" || string == "i" || string == "j" ||
    string == "k" || string == "l" || string == "m" || string == "n" || string == "o" || string == "p" ||
    string  == "q" || string == "r" || string == "s" || string == "t" || string == "u" || string == "v" ||
    string == "w" || string == "x" || string == "y" || string == "z" || string == " " || isBackSpace == -92 ||
    string == "@" || string == "." || string == "1" || string == "2" || string == "3"  || string == "4" ||
    string == "6" || string == "0" || string == "5" || string == "7" || string == "8" || string == "9")
            
            {
                return true
            } else {
                return false
            }

        }
   
        else if(textField == uid) {
            if (
    length < 10 && (string == "1" || string == "2" || string == "3"  || string == "4" || string == "6" ||
    isBackSpace == -92 || string == "0" || string == "5" || string == "7" || string == "8" || string == "9"))
            
            {
                return true;
            }
            else {
                return false;
            }

        }
        
        return true
    }
    
    func tapGesture(_ gesture: UIGestureRecognizer) {
        let alert:UIAlertController = UIAlertController(title: "Profile Picture Options", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let gallaryAction = UIAlertAction(title: "Open Gallary", style: UIAlertActionStyle.default) {
            UIAlertAction in self.openGallary()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in self.cancel()
        }
        
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func openGallary() {
        picker!.allowsEditing = false
        picker!.sourceType = .photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func cancel(){
       // Do Nothing
    }
    
    
    
    func isDefaultImage(_ image: UIImage) -> Bool {
        
        let data1 = UIImagePNGRepresentation(UIImage(named: "NoImage")!)!
        let data2 = UIImagePNGRepresentation(image)
        return (data1 == data2)
    }
	
	
	
	
	func buildIntro() {
		

		
		let header: UIView = Bundle.main.loadNibNamed("IntroHeader", owner: nil, options: nil)![0] as! UIView
	
		let panel1 = MYIntroductionPanel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), title: "Welcome", description: "Welcome to the University of Maryland Audit system. Use this tool to stimulate an actual Degree Audit. This tool provides you access to various features such as GPA Summary, Degree Completion and Instructor's Summary."
			, image: UIImage(named: "testudo"), header: header)
		
		
		
		let panel2 = MYIntroductionPanel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), title: "GPA Summary", description: "GPA Summary provides an overview of your GPA.GPA is based on a 4.0 scale. It also shows your status, i.e. Freshman, Sophomore, Junior, or Senior. It also provides a list of courses and quality points they have earned you."
			, image: UIImage(named: "gpaIntro"))
		
		
		let panel3 = MYIntroductionPanel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), title: "Instructor's Sumary", description: "Instructor's Summary is a powerfull tools to know all the instructors you have taken so far, devided in the Fall and Spring Semester."
			, image: UIImage(named: "instructInfo"))
		
		let panel4 = MYIntroductionPanel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), title: "Course List", description: "Course List allows you personalize the courses you have added. It allows you to edit any course details, and remove the courses you want from this list. Moreover, it presents all the important information about a course."
			, image: UIImage(named: "courses"))
		
		
		let panel5 = MYIntroductionPanel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), title: "Requirements", description: "This feature allows you to track your progress so far. It reflects on the requirements fullfiled and what courses are needed to fullfil the remaining ones. It also tracks the progress by keeping a track of percentage of a degree's completeness."
			, image: UIImage(named: "progress"))
		let panels: NSArray = [panel1,panel2,panel3,panel4,panel5]
		
		let introView = MYBlurIntroductionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
		
		introView.backgroundImageView.image = UIImage(named: "UMD_BigM")
		introView.delegate = self
		introView.setBackgroundColor(blue.withAlphaComponent(0.65))
		self.view.addSubview(introView)
		introView.buildIntroduction(withPanels: panels as [AnyObject])
	
		
	}

  }
