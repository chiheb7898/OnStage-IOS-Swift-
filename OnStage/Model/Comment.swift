//
//  Comment.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 08/05/2022.
//

import Foundation
struct Comment: Encodable{
    internal init(_id: String, text: String, postedBy: String, username: String, userpicture: String) {
        self._id = _id
        self.text = text
        self.postedBy = postedBy
        self.username = username
        self.userpicture = userpicture
    }
    
    var _id:String
    var text:String
    var postedBy:String
    var username:String
    var userpicture:String
    
}
