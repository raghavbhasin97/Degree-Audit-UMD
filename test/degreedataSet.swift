
//  degreedataSet.swift
//  Audit
//
//  Created by Raghav Bhasin on 6/23/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

import UIKit

var degreesData:DegreeManager = DegreeManager()
class degree :NSObject, NSCoding {
    
    var type: String = "Major"
    var field: String = "Undescided"
    
    init(type: String, field: String) {
      self.type = type
      self.field = field

}
    
    func sameName(_ name:String) -> Bool {
        return self.field == name
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(type, forKey: "type")
        aCoder.encode(field, forKey: "field")
    }
    
    required convenience  init?(coder aDecoder: NSCoder) {
       let type = aDecoder.decodeObject(forKey: "type") as! String
       let field = aDecoder.decodeObject(forKey: "field") as! String
        
        self.init(type: type,field: field)
    }
}

class DegreeManager: NSObject, NSCoding {
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("DegreeData")
    
    var degrees = [degree]()
    
    override init() {
        // Do Nothing
    }
    
    init(degrees: [degree]) {
        self.degrees = degrees
    }
    
    func addProgram(_ type: String, field: String) -> Bool{
        if(degreesData.containsDegree(field)) {
            return false
            
        } else {
        degrees.append(degree(type: type, field: field))
            
            return true
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(degrees, forKey: "degrees")
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let degrees = aDecoder.decodeObject(forKey: "degrees") as! [degree]
        
        self.init(degrees: degrees)
    }
    
    func containsDegree(_ name:String) -> Bool {
        for degree in degrees {
            if degree.sameName(name) {
                return true;
            }
        }
        
        return false;
    }

}


