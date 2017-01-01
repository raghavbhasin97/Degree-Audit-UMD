//
//  AddProgram.swift
//  Audit
//
//  Created by Raghav Bhasin on 6/24/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit

class AddProgram : UIViewController {
    
    
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var field : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == type) {
            type.resignFirstResponder()
            field.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
    @IBAction func addProgramm(_ sender: UIButton) {
        if(!(field.text! == "" || type.text! == "")) {
            if(degreesData.addProgram(type.text!, field: field.text!)) {
            NSKeyedArchiver.archiveRootObject(degreesData, toFile: DegreeManager.ArchiveURL.path)
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let vc : UIViewController = storyBoard.instantiateViewController(withIdentifier: "degreeProg")
                
                self.present(vc, animated: false, completion: nil)
            } 

        }
        

    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
    
        if (textField == type) {
            if (string == "A" || string == "B" || string == "C" || string == "D" || string == "E" || string == "F" || string == "G" || string == "H" || string == "I" || string == "J"
                || string == "K" || string == "L" || string == "M" || string == "N" ||
                string == "O" || string == "P" || string  == "Q" || string == "R" || string == "S" || string == "T" || string == "U" || string == "V" || string == "W" || string == "X" || string == "Y" || string == "Z" || isBackSpace == -92) {
                return true;
            }
            else {
                return false;
            }
            
        }

        else {
            if (string == "A" || string == "B" || string == "C" || string == "D" || string == "E" || string == "F" || string == "G" || string == "H" || string == "I" || string == "J"
                || string == "K" || string == "L" || string == "M" || string == "N" ||
                string == "O" || string == "P" || string  == "Q" || string == "R" || string == "S" || string == "T" || string == "U" || string == "V" || string == "W" || string == "X" || string == "Y" || string == "Z" || string == "a" || string == "b" || string == "c" || string == "d" || string == "e" || string == "f" || string == "g" || string == "h" || string == "i" || string == "j"
                
                || string == "k" || string == "l" || string == "m" || string == "n" ||
                
                string == "o" || string == "p" || string  == "q" || string == "r" || string == "s" || string == "t" || string == "u" || string == "v" || string == "w" || string == "x" || string == "y" || string == "z" || string == " " || isBackSpace == -92){
                
                return true;
            }
            else {
                return false
            }
 
        }
    }

}
