//
//  Post.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 20/04/2022.
//

import Foundation


struct Post: Encodable{
    internal init(_id: String? = nil, title: String? = nil, description: String? = nil, photo: String? = nil, postedBy: String? = nil, comments: String? = nil, createdAt: String? = nil, updatedAt: String? = nil) {
        self._id = _id
        self.title = title
        self.description = description
        self.photo = photo
        self.postedBy = postedBy
        self.comments = comments
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    
    var _id : String?
    var title : String?
    var description : String?
    var photo  : String?
    var postedBy : String?
    var comments : String?
    var createdAt : String?
    var updatedAt : String?
}
