//
//  Edit.swift
//  Audit
//
//  Created by Raghav Bhasin on 6/17/16.
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



class EditController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate,UIViewControllerTransitioningDelegate {
    var openingFrame: CGRect!

    
    @IBOutlet weak var classDescription: UITextField!
    @IBOutlet weak var teermControl: UISegmentedControl!
    
    @IBOutlet weak var requirementsField: UITextField!
    @IBOutlet weak var credits: UITextField!
    
    @IBOutlet weak var instructorName: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    var pickerDataSource = ["A+","A","A-","B+","B","B-","C+","C","C-","D","F","P"];
    var gradeData : String!
    var termString = ""
    var defaults = CGFloat(0.0)
    
    let transition = ExpandDeanimator()

    let requirementDatabase  = ["FSAR", "FSAW", "FSMA","FSOC","FSPW","DSHS","DSHU","DSNS","DSNL","DSSP","DVCC","DVUP","SCIS","CORE", "NONE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SecondViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SecondViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        exit(0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerDataSource.count
    }
    
    @IBAction func addCourse(_ sender: UIBarButtonItem) {
    
        
        if(instructorName.text == "No Instructor" && termString == "AP") {
            // It is valid
            instructorName.text = ""
            dataSet.editCourse(Int(self.credits.text!)!, requirements: requirementsField.text!, gradeEarned: gradeData, instructorName: instructorName.text!,term: teermControl.titleForSegment(at: teermControl.selectedSegmentIndex)!, desc: classDescription.text!)
            self.saveCourses()
            openingFrame = OpeningFrame
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let vc : UIViewController = storyBoard.instantiateViewController(withIdentifier: "removeCourses")
            vc.transitioningDelegate  = self
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true, completion: nil)

        }
        
        
        else  if(credits.text! == "" || requirementsField.text! == "" || instructorName.text == "" || classDescription.text == "") {
            let alert = UIAlertController(title: "Attention", message: "All fields are required.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
      

        else {
            dataSet.editCourse(Int(self.credits.text!)!, requirements: requirementsField.text!, gradeEarned: gradeData, instructorName: instructorName.text!,term: teermControl.titleForSegment(at: teermControl.selectedSegmentIndex)!, desc: classDescription.text!)
     
            openingFrame = OpeningFrame
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let vc : UIViewController = storyBoard.instantiateViewController(withIdentifier: "removeCourses")
            vc.transitioningDelegate  = self
            vc.modalPresentationStyle = .custom
            self.present(vc, animated: true, completion: nil)
            
            self.saveCourses()
            
        }
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == credits) {
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
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
                        let index2 = testString.characters.index(index1, offsetBy: -1)
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
                        let index2 = testString.characters.index(index1, offsetBy: -1)
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
            return true;
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
    


    func loadData() {
        let course = dataSet.courses[edittingIndex]
        nameField.text = course.name
        instructorName.text = course.instructorName
        requirementsField.text = course.requirements
        credits.text = String(course.credit)
        gradeData = course.gradeEarned
        termString = course.term
        classDescription.text = course.desc
        
        if(course.term == "FALL") {
            teermControl.selectedSegmentIndex = 0
        }
        else if(course.term == "SPRING"){
            teermControl.selectedSegmentIndex = 1
        }
        else if(course.term == "AP"){
            teermControl.selectedSegmentIndex = 2
        }
        
        if(course.gradeEarned == "A+") {
               pickerView.selectRow(0, inComponent: 0, animated: true)
        } else if(course.gradeEarned == "A") {
               pickerView.selectRow(1, inComponent: 0, animated: true)
        }
        else if(course.gradeEarned == "A-") {
               pickerView.selectRow(2, inComponent: 0, animated: true)
        }
        else if(course.gradeEarned == "B+") {
            pickerView.selectRow(3, inComponent: 0, animated: true)
        }
        else if(course.gradeEarned == "B") {
            pickerView.selectRow(4, inComponent: 0, animated: true)
        } else if(course.gradeEarned == "B-") {
            pickerView.selectRow(5, inComponent: 0, animated: true)
        }
        else if(course.gradeEarned == "C+") {
            pickerView.selectRow(6, inComponent: 0, animated: true)
        }
        else if(course.gradeEarned == "C") {
            pickerView.selectRow(7, inComponent: 0, animated: true)
        }
        else if(course.gradeEarned == "C-") {
            pickerView.selectRow(8, inComponent: 0, animated: true)
        }
        else if(course.gradeEarned == "D") {
            pickerView.selectRow(9, inComponent: 0, animated: true)
        }
        else if(course.gradeEarned == "F") {
            pickerView.selectRow(10, inComponent: 0, animated: true)
        }
        else if(course.gradeEarned == "P") {
            pickerView.selectRow(11, inComponent: 0, animated: true)
        }
        
        if(termString == "AP") {
            pickerView.selectRow(11, inComponent: 0, animated: true)
            pickerView.isUserInteractionEnabled = false
            instructorName.isUserInteractionEnabled = false
            instructorName.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
            instructorName.text = "No Instructor"
            gradeData = "P"
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

            self.view.frame.origin.y = defaults

    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let trans = ExpandDeanimator.animator
        trans.openingFrame = openingFrame!
        
        return trans
    }
    
    @IBAction func cencel(_ sender: UIBarButtonItem) {
        openingFrame = OpeningFrame
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let vc : UIViewController = storyBoard.instantiateViewController(withIdentifier: "removeCourses")
        vc.transitioningDelegate  = self
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: true, completion: nil)

    }
    

}
