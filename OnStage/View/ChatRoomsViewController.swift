//
//  ChatRoomsViewController.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 11/05/2022.
//

import UIKit

class ChatRoomsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var UserName = ["Chiheb Chikhaoui","Jihen Gabsi","Will Smith","The Rock","James Bond"]
    var pic = ["avatarman","avatarwoman","avatarman","avatarman","avatarman"]
    var lastMessage = ["hello..","Hey you","Welcome","What","Im gonna kill ya"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell")
        let contentView = cell?.contentView
        
        let username = contentView?.viewWithTag(2) as! UILabel
        let userimage = contentView?.viewWithTag(1) as! UIImageView
        userimage.layer.masksToBounds = true
        userimage.layer.cornerRadius = userimage.bounds.width / 2
        //let lastmessage = contentView?.viewWithTag(3) as! UILabel
        
        username.text = UserName[indexPath.row]
        userimage.image = UIImage(named: "avatarman")
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
