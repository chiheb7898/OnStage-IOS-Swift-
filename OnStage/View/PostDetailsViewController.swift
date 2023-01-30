//
//  PostDetailsViewController.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 08/04/2022.
//

import UIKit

class PostDetailsViewController: UIViewController {
    
    //var
    var pic:String?
    var titleDet:String?
    var discription:String?
    var date:String?
    var idPost:String?
    
    //widgets
    @IBOutlet weak var postPic: UIImageView!
    @IBOutlet weak var postTitle: UITextView!
    @IBOutlet weak var postDiscription: UITextView!
    @IBOutlet weak var postDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageurl = NSURL(string: pic!)
        let dataimage = NSData(contentsOf: imageurl! as URL)
        postPic.image = UIImage(data: dataimage! as Data)
        postTitle.text = titleDet
        postDiscription.text = discription
        postDate.text = date
        // Do any additional setup after loading the view.
    }
    @IBAction func showcomments(_ sender: Any) {
        performSegue(withIdentifier: "showcomments", sender: sender)
    }
    @IBAction func likebtn(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showcomments"  {
            let destination = segue.destination as! CommentsViewController

            destination.IdPost = idPost
        }

    }
}
