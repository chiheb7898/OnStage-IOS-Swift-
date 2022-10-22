//
//  ChatListViewController.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 07/04/2022.
//

import UIKit

class ChatListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //var
    var UserName = ["Chiheb Chikhaoui","Jihen Gabsi","Will Smith","The Rock","James Bond"]
    var pic = ["avatarman","avatarwoman","avatarman","avatarman","avatarman"]
    var lastMessage = ["hello..","Hey you","Welcome","What","Im gonna kill ya"]
    
    let cellspacing: CGFloat = 5
    
    //Widgets
    
    
    //TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell")
        let contentView = cell?.contentView
        
        cell?.layer.cornerRadius = 5
        
        let username = contentView?.viewWithTag(2) as! UILabel
        let userimage = contentView?.viewWithTag(1) as! UIImageView
        userimage.layer.masksToBounds = true
        userimage.layer.cornerRadius = userimage.bounds.width / 2
        let lastmessage = contentView?.viewWithTag(3) as! UILabel
        
        username.text = UserName[indexPath.row]
        userimage.image = UIImage(named: pic[indexPath.row])
        lastmessage.text = lastMessage[indexPath.row]
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellspacing
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
