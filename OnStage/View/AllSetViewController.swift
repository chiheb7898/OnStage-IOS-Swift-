//
//  AllSetViewController.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 07/05/2022.
//

import UIKit

class AllSetViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UITextField!
    var profilePicture: Any?
    
    var Image: UIImage?
    
    var userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editPicture(_ sender: Any) {
        
        ImagePickerManager().pickImage(self){image in
            self.Image = image
            self.userImage.image = self.Image
        
              }
    }
    
    @IBAction func allSetSubmit(_ sender: Any) {
        
        userViewModel.signup(username: self.username.text!,email: UserDefaults.standard.string(forKey: "email")!, profileImage: self.Image!, completed: { [self] success,user in
            if success {
                
                //set UserDefaults
               
                let tmpuser = user as! UserModel
                UserDefaults.standard.set(tmpuser._id, forKey: "userId")
                UserDefaults.standard.set(tmpuser.picture, forKey: "picture")
                UserDefaults.standard.set(tmpuser.name, forKey: "name")
                UserDefaults.standard.set(tmpuser.email, forKey: "email")
                //UserDefaults.standard.set(user._id, forKey: "token")
                
                
                //go to homepage
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "homepage") as? HomePageControllerViewController
                secondVC!.modalPresentationStyle = .fullScreen
                self.present(secondVC!, animated: true, completion: nil)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Something went wrong!"),animated: true)
            }
        })
        
    }

}
