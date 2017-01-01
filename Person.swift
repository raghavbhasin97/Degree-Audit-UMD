//
//  Person.swift
//  Audit
//
//  Created by Raghav Bhasin on 6/15/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//


import UIKit



class Person: NSObject , NSCoding {
    
    var FirstName:String!
    var lastName:String!
	var UID: Int64 = 99999999
    var email: String!
    var MAJOR: String!
    var photo: UIImage!
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("UserData")
    
    override init() {
        
    // Blank constructor
    }

    init(FirstName: String, lastName: String, UID: Int64, email: String, MAJOR: String, photo: UIImage) {
        self.FirstName = FirstName
        self.lastName = lastName
        self.email = email
        self.UID = UID
        self.MAJOR = MAJOR
        self.photo = photo
    }
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(FirstName, forKey: "firstname")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(UID, forKey: "uid")
        aCoder.encode(MAJOR, forKey: "major")
        aCoder.encode(photo, forKey: "photo")
    }
    
    required convenience  init?(coder aDecoder: NSCoder) {
       
        let FirstName = aDecoder.decodeObject(forKey: "firstname") as! String
        let lastName = aDecoder.decodeObject(forKey: "lastName") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let UID = aDecoder.decodeInt64(forKey: "uid") 
        let MAJOR = aDecoder.decodeObject(forKey: "major") as! String
        let photo = aDecoder.decodeObject(forKey: "photo") as! UIImage
        
        self.init(FirstName: FirstName,lastName: lastName,UID: UID,email: email, MAJOR: MAJOR, photo: photo)
        
    }
    func add(_ FirstName: String, lastName: String, UID: Int64, email: String, MAJOR: String, photo: UIImage) {
        self.FirstName = FirstName
        self.lastName = lastName
        self.email = email
        self.UID = UID
        self.MAJOR = MAJOR
        self.photo = photo
    }
    
    
    deinit {
        photo = nil

        MAJOR = nil
        FirstName = nil
        lastName = nil
        email = nil
    }
    
}
