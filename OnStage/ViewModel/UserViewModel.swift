//
//  UserViewModel.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 07/05/2022.
//

import Foundation
import SwiftyJSON
import Alamofire
import UIKit.UIImage

public class UserViewModel: ObservableObject{
    static let sharedInstance = UserViewModel()
    
    let headers: HTTPHeaders = [ .contentType("application/json")]
    
    //__________SEND CODE
    func callingSendCodeAPI(email: String,completionHandler:@escaping(Bool,String) ->()){
        let parameters: [String: Any] = [
            "email" : email,
        ]
        AF.request(url + "/sendCode", method:.post, parameters: parameters,encoding: JSONEncoding.default,headers: headers).response { response in
            debugPrint(response)
            switch response.result{
            case .success(_):
                do{
                    //let json = try JSONSerialization.jsonObject(with: data!,options: [])
                     let res = String(data: response.data!, encoding: String.Encoding.utf8)
                    if response.response?.statusCode == 200{
                        completionHandler(true,res!)
                    }
                    else{
                        completionHandler(false,"Try again!")
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false,"Try again!")
            }
          
          
        }
      
    }
    
    //__________VERIF CODE
    
    func callingVerifCodeAPI(email:String,completionHandler:@escaping(Bool,String) ->()){
        let parameters: [String: Any] = [
            "email" : email
        ]
        AF.request(url + "/verifCode", method:.post, parameters: parameters,encoding: JSONEncoding.default,headers: headers).response { response in
            debugPrint(response)
            switch response.result{
            case .success(_):
                do{
                    //let json = try JSONSerialization.jsonObject(with: data!,options: [])
                     let res = String(data: response.data!, encoding: String.Encoding.utf8)
                    if response.response?.statusCode == 200{
                        completionHandler(true,res!)
                    }
                    else{
                        completionHandler(false,"Try again!")
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
                completionHandler(false,"Try again!")
            }
          
          
        }
      
    }
    
    
    func editProfile(id: String,username: String, profileImage: UIImage, completed: @escaping (Bool) -> Void ) {
          // let email = UserDefaults.standard.string(forKey: "email")
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(profileImage.jpegData(compressionQuality: 0.5)!, withName: "photo" , fileName: "image.jpeg", mimeType: "image/jpeg")
                
                for (key, value) in
                        [
                            "name":username,
                        ]
                {
                    multipartFormData.append((value.data(using: .utf8))!, withName: key)
                }
                
            },to: url + "/updateInfo",
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
    
    
    func signup(username: String,email: String, profileImage: UIImage, completed: @escaping (Bool,Any?) -> Void ) {
          // let email = UserDefaults.standard.string(forKey: "email")
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(profileImage.jpegData(compressionQuality: 0.5)!, withName: "photo" , fileName: "image.jpeg", mimeType: "image/jpeg")
                
                for (key, value) in
                        [
                            "email":email,
                            "name":username,
                        ]
                {
                    multipartFormData.append((value.data(using: .utf8))!, withName: key)
                }
                
            },to: url + "/signup",
                      method: .post
                      
                      )
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        var User : UserModel = UserModel(_id: "", name: "", email: "", currentPosition: "", companyName: "", currentlyWorking: "", educationTitle: "", school: "", student: "", picture: "")
                        for singleJsonItem in JSON(response.data!) {
                            User = self.makeItem(jsonItem: singleJsonItem.1)
                        }
                        completed(true, User)
                    case let .failure(error):
                        debugPrint(error)
                        completed(false, nil)
                    }
                }
        }
    
    func getAllUsers(completed: @escaping (Bool, Any? ) -> Void) {
        AF.request(url + "/allusers",
                   method: .get
                       )
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    var Users : [UserModel]? = []
                    for singleJsonItem in JSON(response.data!)["users"]{
                        Users!.append(self.makeItem(jsonItem: singleJsonItem.1))
                    }
                    completed(true, Users)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
        }
    
    
    func makeItem(jsonItem: JSON) -> UserModel {
            //let isoDate = jsonItem["dateNaissance"]
            return UserModel(
                _id: jsonItem["_id"].stringValue,
                name: jsonItem["name"].stringValue,
                email: jsonItem["email"].stringValue,
                currentPosition: jsonItem["currentPosition"].stringValue,
                companyName: jsonItem["companyName"].stringValue,
                currentlyWorking: jsonItem["currentlyWorking"].stringValue,
                educationTitle: jsonItem["educationTitle"].stringValue,
                school: jsonItem["school"].stringValue,
                student: jsonItem["student"].stringValue,
                picture: jsonItem["picture"].stringValue
            )
        }
    
    
}
