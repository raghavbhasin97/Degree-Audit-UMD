//
//  SecondViewController.swift
//  test
//
//  Created by Raghav Bhasin on 6/12/16.
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


class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,UIViewControllerTransitioningDelegate {
	
	
	
	
	
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var classDescription: UITextField!
    @IBOutlet weak var teermControl: UISegmentedControl!
    
    @IBOutlet weak var requirementsField: UITextField!
    @IBOutlet weak var credits: UITextField!

    @IBOutlet weak var instructorName: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    var pickerDataSource = ["A+","A","A-","B+","B","B-","C+","C","C-","D","F","P"];
    var gradeData : String = String("A+")
    var termString = "FALL"
    
    var defaults = CGFloat(0.0)
  let requirementDatabase  = ["FSAR", "FSAW", "FSMA","FSOC","FSPW","DSHS","DSHU","DSNS","DSNL","DSSP","DVCC","DVUP","SCIS","CORE","NONE"]
    @IBAction func save(_ sender: UIBarButtonItem) {
        addCourse()
    }
  
    var preReqs: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        defaults =  self.view.frame.origin.y
        
        NotificationCenter.default.addObserver(self, selector: #selector(SecondViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SecondViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        navigationBar.titleTextAttributes
            = [NSForegroundColorAttributeName: UIColor(netHex:0x8D000A),
               NSFontAttributeName: UIFont(name: "ChalkboardSE-Bold", size: 19.0)!]
        saveButton.style = .done
        saveButton.isEnabled = false
		
		nameField.becomeFirstResponder();
       
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        credits.text = ""
        instructorName.text = ""
        nameField.text = ""
        requirementsField.text = ""
        pickerView.selectRow(0, inComponent: 0, animated: true)
        teermControl.selectedSegmentIndex = 0
        nameField.resignFirstResponder()
        credits.resignFirstResponder()
        instructorName.resignFirstResponder()
        requirementsField.resignFirstResponder()
        instructorName.isUserInteractionEnabled = true
        instructorName.backgroundColor = UIColor.clear
        classDescription.text = ""
        saveButton.isEnabled = false
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        saveCourses()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerDataSource.count
    }
    
    func addCourse() {
        if(preReqValid(nameField.text!)) {
            
        
        if(instructorName.text == "No Instructor" && termString == "AP") {
            // It is valid
        if(!dataSet.add(nameField.text!, credit: Int(self.credits.text!)!, requirements: requirementsField.text!, gradeEarned: gradeData, instructorName: instructorName.text!,term: teermControl.titleForSegment(at: teermControl.selectedSegmentIndex)!, desc: classDescription.text!)) {
                let alert = UIAlertController(title: "Dupplicate Courses", message: "A course can be taken only once.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
            self.saveCourses()
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let vc : UITabBarController = storyBoard.instantiateViewController(withIdentifier: "mainWindow") as!
            UITabBarController
			vc.modalPresentationStyle = .custom
			vc.transitioningDelegate = self
            
            self.present(vc, animated: true, completion: nil)
        }
            else {
            if(!dataSet.add(nameField.text!, credit: Int(self.credits.text!)!, requirements: requirementsField.text!, gradeEarned: gradeData, instructorName: instructorName.text!,term: teermControl.titleForSegment(at: teermControl.selectedSegmentIndex)!, desc: classDescription.text!)) {
                let alert = UIAlertController(title: "Dupplicate Courses", message: "A course can be taken only once.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
           
            self.saveCourses()
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let vc : UITabBarController = storyBoard.instantiateViewController(withIdentifier: "mainWindow") as!
            UITabBarController
			vc.modalPresentationStyle = .custom
			vc.transitioningDelegate = self
		
			present(vc, animated: true, completion: nil)

        }
        
        } else {
            let alert = UIAlertController(title: "Missing Prerequisites", message: "The following Prerequisites have not been completed: \(preReqs)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{(alert: UIAlertAction!) in self.decideresponder()}
                ))
            self.present(alert, animated: true, completion: nil)

        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == nameField) {
       
            let str = nameField.text!
            let length = str.characters.count

            if(length < 7) {
                nameField.text = ""
            } else {
                nameField.resignFirstResponder()
                credits.becomeFirstResponder()

               
            }
            
        }
        else if (textField == credits) {
            credits.resignFirstResponder()
            instructorName.becomeFirstResponder()
        }
        else if (textField == instructorName) {
            instructorName.resignFirstResponder()
            requirementsField.becomeFirstResponder()

        }
        else if (textField == requirementsField){
            
            if(requirementsField.text?.characters.count < 4) {
                  requirementsField.text = ""
            }
            
            if(requirementsField.text?.characters.count == 4) {
            if(!requirementDatabase.contains(requirementsField.text!)){
                requirementsField.text = ""
            }
            }
            
            if (requirementsField.text?.characters.count > 4 && requirementsField.text?.characters.count < 9) {
                let index = requirementsField.text!.characters.index(requirementsField.text!.startIndex, offsetBy: 4)
                requirementsField.text = requirementsField.text!.substring(to: index)
            }
            
            if (requirementsField.text?.characters.count == 9) {
                let stringCopy = requirementsField.text!
                let index1  = stringCopy.characters.index(stringCopy.endIndex, offsetBy: -4)
                let testString = stringCopy.substring(from: index1)
                if(!requirementDatabase.contains(testString)) {
					let index2 = stringCopy.characters.index(index1, offsetBy: -1)
                    requirementsField.text = stringCopy.substring(to: index2)
                }
                
            }
            
              if (requirementsField.text?.characters.count > 9 && requirementsField.text?.characters.count < 14) {
                let index = requirementsField.text!.characters.index(requirementsField.text!.startIndex, offsetBy: 9)
                requirementsField.text = requirementsField.text!.substring(to: index)
            }
            requirementsField.resignFirstResponder()
            classDescription.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        isSaveEnabled()
        return true
    }
   
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSaveEnabled()
        self.view.endEditing(true)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
        if (row == 0) {
            gradeData = String("A+")
            
        }
        else if (row == 1) {
           gradeData = "A"
        }
        else if (row == 2) {
            gradeData = "A-"
        }
        else if (row == 3) {
            gradeData = "B+"
        }
        else if (row == 4) {
            gradeData = "B"
        }
        else if (row == 5) {
            gradeData = "B-"
        }
        else if (row == 6) {
            gradeData = "C+"
        }
        else if (row == 7) {
            gradeData = "C"
        }
        else if (row == 8) {
            gradeData = "C-"
        }
        else if (row == 9) {
            gradeData = "D"
        }
        else if (row == 10) {
            gradeData = "F"
        }
        else if (row == 11) {
            gradeData = "P"
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        let length = (textField.text?.characters.count)! + string.characters.count
      if (textField == credits) {
        if (length < 2 && (string == "1" || string == "2" || string == "3"  || string == "4"
            || string == "6" || isBackSpace == -92)) {
    
          return true;
        }
        else {
            return false;
        }
    }
      else if (textField == nameField) {
                if (length < 9  && (string == "A" || string == "B" || string == "C" || string == "D" || string == "E" || string == "F" || string == "G" || string == "H" || string == "I" || string == "J"
            || string == "K" || string == "L" || string == "M" || string == "N" ||
            string == "O" || string == "P" || string  == "Q" || string == "R" || string == "S" || string == "T" || string == "U" || string == "V" || string == "W" || string == "X" || string == "Y" || string == "Z" || string == "1" || string == "2" || string == "3"  || string == "4" || string == "5" || string == "6" || string == "7" || string == "8" ||
                string == "9" || string == "0" || isBackSpace == -92)) {
            return true;
        }
        else {
            return false;
        }

      }
        
      else if (textField == classDescription) {
        if (string == "A" || string == "B" || string == "C" || string == "D" || string == "E" || string == "F" || string == "G" || string == "H" || string == "I" || string == "J"
            || string == "K" || string == "L" || string == "M" || string == "N" ||
            string == "O" || string == "P" || string  == "Q" || string == "R" || string == "S" || string == "T" || string == "U" || string == "V" || string == "W" || string == "X" || string == "Y" || string == "Z" || string == " " || isBackSpace == -92 || string == "&") {
            return true;
        }
        else {
            return false;
        }
        
      }

      else if(textField == instructorName) {
        
        
        if (string == "A" || string == "B" || string == "C" || string == "D" || string == "E" || string == "F" || string == "G" || string == "H" || string == "I" || string == "J"
        || string == "K" || string == "L" || string == "M" || string == "N" ||
        string == "O" || string == "P" || string  == "Q" || string == "R" || string == "S" || string == "T" || string == "U" || string == "V" || string == "W" || string == "X" || string == "Y" || string == "Z" || string == "a" || string == "b" || string == "c" || string == "d" || string == "e" || string == "f" || string == "g" || string == "h" || string == "i" || string == "j"
        
        || string == "k" || string == "l" || string == "m" || string == "n" ||
        
        string == "o" || string == "p" || string  == "q" || string == "r" || string == "s" || string == "t" || string == "u" || string == "v" || string == "w" || string == "x" || string == "y" || string == "z" || string == " " || isBackSpace == -92 ||
        string == "-" || string == "."){
            
       return true;
      }
        else {
            return false
        }
    }
     
      else if (textField == requirementsField) {
        if (length < 15 && (string == "A" || string == "B" || string == "C" || string == "D" || string == "E" || string == "F" || string == "G" || string == "H" || string == "I" || string == "J"
            || string == "K" || string == "L" || string == "M" || string == "N" ||
            string == "O" || string == "P" || string  == "Q" || string == "R" || string == "S" || string == "T" || string == "U" || string == "V" || string == "W" || string == "X" || string == "Y" || string == "Z" || isBackSpace == -92)) {
        
            if(length == 5 && isBackSpace != -92) {
                if(!requirementDatabase.contains(requirementsField.text!)) {
                    requirementsField.text = ""
                } else {
                requirementsField.text = requirementsField.text! + ","
                }
            }
            if(length == 10 && isBackSpace != -92) {
                let stringCopy = requirementsField.text!
                let index1 = stringCopy.characters.index(stringCopy.endIndex, offsetBy: -4)
                let testString = stringCopy.substring(from: index1)
                
                if(!requirementDatabase.contains(testString)) {
					let index2 = stringCopy.characters.index(index1, offsetBy: -1)
                                       requirementsField.text = stringCopy.substring(to: index2) + ","
                
                } else {
                  requirementsField.text = requirementsField.text! + ","
                }
            }
            
            if (length == 14 && isBackSpace != -92) {
                let stringCopy = requirementsField.text! + string
                let index1 = stringCopy.characters.index(stringCopy.endIndex, offsetBy: -4)
                let testString = stringCopy.substring(from: index1)
                
                if(!requirementDatabase.contains(testString)) {
					let index2 = stringCopy.characters.index(index1, offsetBy: -1)
                    requirementsField.text = stringCopy.substring(to: index2)
                    return false
                    
                } else {
                    return true
                }

            }
         return true
        }
        else {
            return false;
        }
      }
        
      else {
        return false;
        }
    
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func saveCourses() {
   
        NSKeyedArchiver.archiveRootObject(dataSet, toFile: CorseManager.ArchiveURL.path)
    
    }
    @IBAction func selectTerm(_ sender: UISegmentedControl) {
        termString = sender.titleForSegment(at: sender.selectedSegmentIndex)!
        if(termString == "AP") {
              pickerView.selectRow(11, inComponent: 0, animated: true)
              pickerView.isUserInteractionEnabled = false
              instructorName.isUserInteractionEnabled = false
              instructorName.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
              instructorName.text = "No Instructor"
              gradeData = "P"
        } else {
            pickerView.isUserInteractionEnabled = true
            instructorName.isUserInteractionEnabled = true
            instructorName.backgroundColor = UIColor.clear
            if(instructorName.text == "No Instructor") {
                instructorName.text = ""
            }
            else {
                instructorName.text = instructorName.text
            }
        

        }
    }
    
    
    func decideresponder() {
        if(nameField.text! == "") {
            nameField.becomeFirstResponder()
        }
        else if (credits.text! == "") {
            credits.becomeFirstResponder()
        } else if(requirementsField.text! == "") {
            requirementsField.becomeFirstResponder()
        } else if(instructorName.text! == "") {
            instructorName.becomeFirstResponder()
        }

    }
    
    func keyboardWillShow(_ notification: Notification) {
        if(classDescription.isEditing) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            self.view.frame.origin.y -= keyboardSize.height
        }
            
          

        }
        
    }
    
    func keyboardWillHide(_ notification: Notification) {
        isSaveEnabled()
            self.view.frame.origin.y = defaults
        
    }
    
    
    func preReqValid(_ name: String) -> Bool{
        preReqs = ""
      let data = preReqDictionary[name]
        var flag = false
        
      
        if(data != nil) {
            for data1 in data! {
                if (!dataSet.containsCourse(data1)) {
                    preReqs += data1 + " "
                }
            }
            
        for elements in data! {
            if (dataSet.containsCourse(elements)) {
                flag = true
            } else {
                flag = false
                break
            }
        }
        } else {
            flag = true
        }
        return flag
        
    }
    
    
    func isSaveEnabled() {
        if(nameField.text! == "" || credits.text! == "" || requirementsField.text! == "" || instructorName.text == "" || classDescription.text == "") {
            saveButton.isEnabled = false
        } else {
              saveButton.isEnabled = true
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
         textField.addTarget(self, action: #selector(SecondViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        isSaveEnabled()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
     
       isSaveEnabled()
    }
    
    
    func textFieldDidChange(_ textField: UITextField) {
            isSaveEnabled()
    }
	
	
	
	
	
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		let trans = SaveTransition.animator

		return trans
	}

	

    

   }





