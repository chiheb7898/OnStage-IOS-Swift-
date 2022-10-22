//
//  PostViewModel.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 20/04/2022.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit.UIImage

public class PostViewModel: ObservableObject{
    
    static let sharedInstance = PostViewModel()
    
    func getAllPostes( completed: @escaping (Bool, Any? ) -> Void) {
          //  print(user)
        AF.request(url + "/allpost",
                       method: .get
                       )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var Posts : [Post]? = []
                    for singleJsonItem in JSON(response.data!)["posts"] {
                        Posts!.append(self.makeItem(jsonItem: singleJsonItem.1))
                    }
                    completed(true, Posts)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
        }
    
    func addNews(title: String,description: String,username:String, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
          // let email = UserDefaults.standard.string(forKey: "email")
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "photo" , fileName: "image.jpeg", mimeType: "image/jpeg")
                
                for (key, value) in
                        [
                            "title":title,
                            "description":description,
                            "username": username,
                        ]
                {
                    multipartFormData.append((value.data(using: .utf8))!, withName: key)
                }
                
            },to: url + "/createpost",
                      method: .post
                      
                      )
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        print("Success")
                        completed(true)
                    case let .failure(error):
                        completed(false)
                        print(error)
                    }
                }
        }
    
    
    
    func makeItem(jsonItem: JSON) -> Post {
            //let isoDate = jsonItem["dateNaissance"]
            return Post(
                _id: jsonItem["_id"].stringValue,
                title: jsonItem["title"].stringValue,
                description: jsonItem["description"].stringValue,
                photo: jsonItem["photo"].stringValue,
                postedBy: jsonItem["postedBy"].stringValue,
                comments: jsonItem["comments"].stringValue,
                createdAt: jsonItem["createdAt"].stringValue,
                updatedAt: jsonItem["updatedAt"].stringValue
            )
        }
    
}
