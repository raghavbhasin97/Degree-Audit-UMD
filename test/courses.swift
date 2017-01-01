//
//  courses.swift
//  Audit
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
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}





//MARK: Course Object
/*
 This class defines a course object that represents a Course. It has a Name, Number of Credits, Requirements
 Grade Earned, and Instructor Name.
 */

class Course: NSObject, NSCoding{
    
    var name:String
    var credit:Int
    var requirements:String
    var gradeEarned:String
    var instructorName:String
    var term:String
    var desc: String
    
    
    
    // Constructor to initialize a Course Object
    init(name:String, credit:Int, requirements:String, gradeEarned:String, instructorName:String,term: String, desc: String) {
        self.name = name;
        self.credit = credit;
        self.requirements = requirements
        self.gradeEarned = gradeEarned
        self.instructorName = instructorName
        self.term = term
        self.desc = desc
    }
 
   
    // returns true if the parameter name and Course name are same
    func sameName(_ name:String) -> Bool {
        return self.name == name
    }
    

    // Preapres the object for being archived/Saved
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(requirements, forKey: "requirements")
        aCoder.encode(gradeEarned, forKey: "gradeEarned")
        aCoder.encode(instructorName, forKey: "instructorName")
        aCoder.encode(credit, forKey: "credit")
        aCoder.encode(term, forKey: "term")
        aCoder.encode(desc, forKey: "desc")
    }
    
    // Use to decode the object and prepare it for being unarchived/Loaded
    required convenience  init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let requirements = aDecoder.decodeObject(forKey: "requirements") as! String
        let gradeEarned = aDecoder.decodeObject(forKey: "gradeEarned") as! String
        let instructorName = aDecoder.decodeObject(forKey: "instructorName") as! String
        let credit = aDecoder.decodeInteger(forKey: "credit")
        let term = aDecoder.decodeObject(forKey: "term") as! String
        let desc = aDecoder.decodeObject(forKey: "desc") as! String
        
        self.init(name: name,credit: credit,requirements: requirements,gradeEarned: gradeEarned, instructorName: instructorName, term: term, desc: desc)
    }

    func qualifiesConc() -> Bool{
        let str = name.substring(from: name.index(name.startIndex, offsetBy: 4))
        let num = Int(str)
        return (num >= 300 && num <= 499)
    }
    
    func extractCode() -> String{
        return name.substring(to: name.index(name.startIndex, offsetBy: 4))
    }
}


//MARK: CourseManager Object

class CorseManager: NSObject, NSCoding {
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("CorseManager")
    var courses =  [Course]()
    var numberOfCredits = 0
    
    override init() {
        // Do Nothing
    }
    init(courses : [Course], numberOfCredits : Int) {
        self.courses = courses
        self.numberOfCredits = numberOfCredits
    }
    func add(_ name:String, credit:Int, requirements:String, gradeEarned:String, instructorName:String, term: String, desc: String) -> Bool {
        if self.containsCourse(name) {
            return false;
        }
        else {
            courses.append(Course(name: name,credit: credit,requirements: requirements,gradeEarned: gradeEarned,instructorName: instructorName,term: term, desc: desc))
            numberOfCredits += credit
            
            return true;
        }
        
        
    }
    
    func containsCourse(_ name:String) -> Bool {
        for course in courses {
            if course.sameName(name) {
                return true;
            }
        }
        
        return false;
    }

    
    func editCourse(_ credit:Int, requirements:String, gradeEarned:String, instructorName:String, term: String,
                    desc: String) {
        let currentCourse = dataSet.courses[edittingIndex]
        let currentCredits = currentCourse.credit
        currentCourse.credit = credit
        currentCourse.requirements = requirements
        currentCourse.gradeEarned = gradeEarned
        currentCourse.instructorName = instructorName
        currentCourse.term = term
        currentCourse.desc = desc
        
        numberOfCredits += (credit - currentCredits)
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(courses, forKey: "coursesData")
        aCoder.encode(numberOfCredits, forKey: "credits")
       
    }
    
    func returnCredits(_ name: String) -> Int{
        for course in dataSet.courses {
            if(course.sameName(name)) {
                return course.credit
            }
        }
        
        return 0
    }
    
  required convenience  init?(coder aDecoder: NSCoder) {
        let courses = aDecoder.decodeObject(forKey: "coursesData") as! [Course]
        let numberOfCredits = aDecoder.decodeInteger(forKey: "credits")
    
    self.init(courses: courses, numberOfCredits : numberOfCredits)
    }
    
    func sort() {

        courses.sort(by: {$0.name < $1.name})
        
    }
    
    func sortInstructor() {
        courses.sort(by: {$0.instructorName < $1.instructorName})
    }
    
    func sortTerm() {
        
        courses.sort(by: {$0.term < $1.term})
        
    }
    

    func calcGPA(_ data: CorseManager) -> Double {
        var actualCredits = 0
        var qualityPoint = 0.0
        for courses in data.courses {
            if (returnQp(courses.gradeEarned) != MARK && courses.term != "AP") {
                actualCredits += courses.credit
                qualityPoint += Double(courses.credit) * returnQp(courses.gradeEarned)
                
                
                
            }
            
            
        }
        if (qualityPoint == 0) {
            return 0.0
        } else {
            
            return qualityPoint/Double(actualCredits)
        }
        
    }

    func majorCoursesGPA() -> Double{
        let majorDataset = CorseManager()
        
        for course in dataSet.courses {
            if(course.requirements.components(separatedBy: ",").contains("CORE")) {
                majorDataset.courses.append(course)
                majorDataset.numberOfCredits += course.credit
            }
        }
        
        return calcGPA(majorDataset)
    }
    
       func genEdCoursesGPA() -> Double {
        let genEdDataset = CorseManager()
        
        for course in dataSet.courses {
            if(!(course.requirements.components(separatedBy: ",").contains("CORE") || course.requirements.components(separatedBy: ",").contains("NONE"))){
                genEdDataset.courses.append(course)
                genEdDataset.numberOfCredits += course.credit
            }
        }
        

        return calcGPA(genEdDataset)
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

    func returnMCreditsPercent() -> Int{
      
            let majorDataset = CorseManager()
            
            for course in dataSet.courses {
                if(course.requirements.components(separatedBy: ",").contains("CORE")) {
                    majorDataset.courses.append(course)
                    majorDataset.numberOfCredits += course.credit
                }
            }
     
        return Int((majorDataset.numberOfCredits*100/80))
    }
    
    func returnGCreditsPercent() -> Int{
        
        let genEdDataset = CorseManager()
        
        for course in dataSet.courses {
            if(!(course.requirements.components(separatedBy: ",").contains("CORE") || course.requirements.components(separatedBy: ",").contains("NONE"))){
                genEdDataset.courses.append(course)
                genEdDataset.numberOfCredits += course.credit
            }
        }
        return Int((genEdDataset.numberOfCredits*100/40))
    }
}
