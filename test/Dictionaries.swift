//
//  Disctionaries.swift
//  Audit
//
//  Created by Raghav Bhasin on 7/5/16.
//  Copyright © 2016 Test Apps. All rights reserved.
//

//MARK: Global Variables
// Globally Defined variable to access the data set

var offset_table: CGFloat = 0.0

var OpeningFrame: CGRect!
var TOPVIEW: UIView!
var BOTTOMVIEW: UIView!


var isReturning = false
var dataSet : CorseManager = CorseManager()
var edittingIndex = -1
var distributiveCoursesDataTrack:[String] = []

let MARK = 5.0

var chartVIEW: CGRect!
var User: Person = Person()
let factor = User.photo.size.width/User.photo.size.height

//MARK: PreRequisite Dictionary
let preReqDictionary: [String: [String]] = ["MATH141" : ["MATH140"], "STAT400" : ["MATH141"], "CMSC132": ["CMSC131", "MATH140"], "CMSC250": ["CMSC131", "MATH141"], "CMSC216" : ["CMSC132","MATH141"], "CMSC330":["CMSC216","CMSC250"],"CMSC351":["CMSC216","CMSC250"],"CMSC411":["CMSC330"],"CMSC412":["CMSC430"],"CMSC414":["CMSC330","CMSC351"], "CMSC417":["CMSC330", "CMSC351"], "CMSC420" :["CMSC330", "CMSC351"], "CMSC421":["CMSC330", "CMSC351"],"CMSC422":["CMSC330", "CMSC351"],"CMSC43":["CMSC330", "CMSC351"],"CMSC424":["CMSC330", "CMSC351"],"CMSC426":["CMSC420"],"CMSC430":["CMSC330", "CMSC351"],"CMSC433":["CMSC330"],"CMSC434":["CMSC330", "CMSC351","PSYC100"], "CMSC435":["CMSC430"], "CMSC436":["CMSC330", "CMSC351"],"CMSC451":["CMSC351"], "CMSC456":["CMSC330", "CMSC351"],"CMSC460":["CMSC131", "MATH240", "MATH241"],"CMSC466":["CMSC131", "MATH240", "MATH241"],"CMSC474" :["CMSC330 ", "CMSC351"],"MATH240":["MATH141"],"MATH241":["MATH141"],"MATH246":["MATH141"]]






//MARK: Course Code Dictionary

let courseCode:[String:String] = ["ASTR":"Astronomy","" : "","MATH": "Mathematics","STAT":"Statistics & Probability","CMSC":"Computer Science"]





