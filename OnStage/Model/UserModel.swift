//
//  UserModel.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 07/05/2022.
//

import Foundation

struct UserModel : Encodable{
    internal init(_id: String, name: String, email: String, currentPosition: String, companyName: String, currentlyWorking: String, educationTitle: String, school: String, student: String, picture: String) {
        self._id = _id
        self.name = name
        self.email = email
        self.currentPosition = currentPosition
        self.companyName = companyName
        self.currentlyWorking = currentlyWorking
        self.educationTitle = educationTitle
        self.school = school
        self.student = student
        self.picture = picture
    }
    
    var _id: String!
    var name: String!
    var email:String!
    var currentPosition:String!
    var companyName:String!
    var currentlyWorking:String!
    var educationTitle:String!
    var school:String!
    var student:String!
    var picture:String!
}
