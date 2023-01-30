//
//  CommentsViewController.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 10/05/2022.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource {
    
    var UserName = ["Chiheb Chikhaoui","Jihen Gabsi","Will Smith","The Rock","James Bond"]
    var pic = ["avatarman","avatarwoman","avatarman","avatarman","avatarman"]
    var lastMessage = ["hello..","Hey you","Welcome","What","Im gonna kill ya"]
    
    //var postsViewModel = PostViewModel()
    var comments = [Comment]()
    var IdPost: String!
    
    let cellSpacingHeight: CGFloat = 30
    @IBOutlet weak var commentsTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell")
        let contentView = cell?.contentView
        
        let username = contentView?.viewWithTag(2) as! UILabel
        let userimage = contentView?.viewWithTag(1) as! UIImageView
        let text = contentView?.viewWithTag(3) as! UITextView
        
        username.text = comments[indexPath.row].username
        
        let imageurl = NSURL(string: comments[indexPath.row].userpicture)
        let dataimage = NSData(contentsOf: imageurl! as URL)
        userimage.image = UIImage(data: dataimage! as Data)
        
        text.text = comments[indexPath.row].text
        
        
        
        return cell!
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }
    
    func initialize() {
        PostViewModel.sharedInstance.getComments(id: IdPost){ success, commentsfromRep in
            if success {
                self.comments = commentsfromRep! as! [Comment]
                self.commentsTable.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load Comments"),animated: true)
            }
        }
    }
    
    
    
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
            initialize()
        }
    
    @IBAction func sendComment(_ sender: Any) {
        
        PostViewModel.sharedInstance.AddComments(idpost: self.IdPost,
                                                 text: self.commentTextField.text!,
                                                 postedBy: UserDefaults.standard.string(forKey: "userId")!,
                                                 username: UserDefaults.standard.string(forKey: "name")!,
                                                 userpicture: UserDefaults.standard.string(forKey: "picture")!) { res in
            if res{
                self.initialize()
                self.commentsTable.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not Add Comment"),animated: true)
            }
        }
        
    }

}
