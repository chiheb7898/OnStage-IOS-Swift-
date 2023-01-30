//
//  ChatListViewController.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 07/04/2022.
//

import UIKit
import Starscream
import SocketIO

class ChatListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    //var
    
    let manager = SocketManager(socketURL: URL(string: url)!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    var users = [UserModel]()
    
    let cellspacing: CGFloat = 5
    
    //Widgets
    @IBOutlet weak var chatrooms: UITableView!
    
    
    //TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell")
        let contentView = cell?.contentView
        
        let username = contentView?.viewWithTag(2) as! UILabel
        let userimage = contentView?.viewWithTag(1) as! UIImageView
        userimage.layer.masksToBounds = true
        userimage.layer.cornerRadius = userimage.bounds.width / 2
        //let lastmessage = contentView?.viewWithTag(3) as! UILabel
        
        username.text = users[indexPath.row].name
        
        let imageurl = NSURL(string: users[indexPath.row].picture)
        let dataimage = NSData(contentsOf: imageurl! as URL)
        if (dataimage != nil){
            userimage.image = UIImage(data: dataimage! as Data)
        }
        else{
            userimage.image = UIImage(named: "avatarman")
        }
        //lastmessage.text = lastMessage[indexPath.row]
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("selected")
        if UserDefaults.standard.string(forKey: "name") != "" {
            self.showSpinner(onView: self.view)
            if let nameOfUser = UserDefaults.standard.string(forKey: "name") {
                self.socket.emitWithAck("join", nameOfUser).timingOut(after: 1) {
                    data in
                    self.removeSpinner()
                    self.performSegue(withIdentifier: "chatMsg", sender: indexPath)
                }
            }
        } else { self.present(Alert.makeAlert(titre: "Error", message: "Can't Join Room"), animated: true) }
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "chatMsg", sender: nil)
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatMsg"  {
            let indexPath = sender as! IndexPath
            let destination = segue.destination as! ChatViewController
            
            destination.destuser = users[indexPath.row]
            destination.socket = self.socket
            
            
        }

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        socket = manager.defaultSocket
        socket.on(clientEvent: .connect) { data, ack in print("socket connected") }
        socket.connect()
    }
    
    override func viewDidAppear(_ animated: Bool) {
            initialize()
        }
    
    func initialize() {
        UserViewModel.sharedInstance.getAllUsers{success, Usersrep in
            if success {
                self.users = Usersrep! as! [UserModel]
                self.chatrooms.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load Chat Rooms"),animated: true)
            }
        }
    }

}
