//
//  ChatViewController.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 10/05/2022.
//

import UIKit
import SocketIO

class ChatViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var nameOfUser = ""
    var socket: SocketIOClient!
    var chat = [Message]()
    var destuser : UserModel!
    
    //Chat
    @IBOutlet weak var chatArea: UITableView!
    @IBOutlet weak var msgContent: UITextField!
    
    //@IBOutlet weak var chatTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return chat.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chat[indexPath.row].user == UserDefaults.standard.string(forKey: "name") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myChat-msg") as! MyChatCollectionViewCell
            cell.titleMsg.text = chat[indexPath.row].user
            cell.detailMsg.text = chat[indexPath.row].msg
            cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "chat-msg") as! ChatCollectionViewCell
            cell.titleMsg?.text = chat[indexPath.row].user
            cell.detailMsg?.text = chat[indexPath.row].msg
            cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
            return cell
        }
    }
    // cells properties and formating
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {return 200}

    //Label of Text
    
    
    //Send Mensage
    @IBAction func sendMessagebtn(_ sender: Any) {
        self.sendMensage()
    }
    
    func sendMensage(){
        guard let msg = msgContent.text else {return}
        if msg != "" {
            self.socket.emit("send", msg)
            msgContent.text = ""
        }
    }
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chatArea.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        self.socket?.on("chat", callback: { (data, ack) in
            guard let user = data[0] as? String else { return }
            guard let msg = data[1] as? String else { return }
            self.chat = self.chat.reversed()
            self.chat.append(Message(user: user, msg: msg))
            self.chat = self.chat.reversed()
            self.chatArea.reloadData()
        })
        
        //Move view with keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    //Move view with keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height + 17)
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //Hide Keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
