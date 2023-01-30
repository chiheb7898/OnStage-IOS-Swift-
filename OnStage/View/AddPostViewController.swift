//
//  AddPostViewController.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 20/04/2022.
//

import UIKit

class AddPostViewController: UIViewController, UITextViewDelegate {
    
    var PostImage: Any?
    var Image: UIImage?

    
    var postsViewModel = PostViewModel()
    
    
    //widgets
    @IBOutlet weak var textBody: UITextView!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var ImagePost: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textBody.text = "What's on your mind?"
        textBody.textColor = .lightGray
        
        userName.text = UserDefaults.standard.string(forKey: "name")!
        
        let profileimageurl = NSURL(string: UserDefaults.standard.string(forKey: "picture")!)
        var profiledataimage = NSData(contentsOf: profileimageurl as! URL)
        profileImage.image = UIImage(data: profiledataimage as! Data)
        
        

        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textBody: UITextView){
        if textBody.textColor == UIColor.lightGray {
            textBody.text = nil
            textBody.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textBody: UITextView){
        if textBody.text.isEmpty {
            textBody.text = "What's on your mind?"
            textBody.textColor = .lightGray
        }
    }
    
    //IBActions
    @IBAction func AddPost(_ sender: Any) {
        postsViewModel.addNews(title:titleTextfield.text!, description:textBody.text!,username: "username!", uiImage: Image!,  completed: { [self] success in
                    if success {
                       // self.performSegue(withIdentifier: "HomeFactCheckSegueAgency", sender: nil)
                       self.present(Alert.makeAlert(titre: "Succes", message: "news add successfully"),animated: true)
                    
                    } else {
                        self.present(Alert.makeAlert(titre: "Error", message: "Something went wrong!"),animated: true)
                    }
                })
    }
    
    @IBAction func AddImage(_ sender: Any) {
        
        ImagePickerManager().pickImage(self){image in
            self.Image = image
            self.ImagePost.image = image
            //_ = SendImageToCloudinary(image: self.ImagePost)
        }
    }
    
    func goBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
