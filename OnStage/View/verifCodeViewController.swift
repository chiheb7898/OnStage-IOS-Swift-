//
//  verifCodeViewController.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 07/05/2022.
//

import UIKit

class verifCodeViewController: UIViewController {
    
    @IBOutlet weak var code: UITextField!
    
    var email = ""
    var code1 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*if let code1 = UserDefaults.standard.value(forKey: "code") as? String {
            self.code1 = code1
        }
        if let email = UserDefaults.standard.value(forKey: "email") as? String {
            self.email = email
        }
        print("cc:"+email)
        // Do any additional setup after loading the view.*/
    }
    
    @IBAction func verifAction(_ sender: Any) {
        guard let code2 = self.code.text else {return}
        
        if let code1 = UserDefaults.standard.value(forKey: "code") as? String {
            self.code1 = code1
        }
        if let email = UserDefaults.standard.value(forKey: "email") as? String {
            self.email = email
        }
        print("cc:"+email)

        print("code2:" + code2)
        print( "code1:" +  code1)



        if(code1 == code2){
            UserViewModel.sharedInstance.callingVerifCodeAPI(email: self.email){ [self]
                (isSuccess,found) in
                if isSuccess{
                    let json = Data(found.utf8)
                    let jj = (try? JSONSerialization.jsonObject(with: json, options:[] )) as? [String:String]
                   
                    let found = jj?["found"] ?? " "
                    let userId = jj?["userId"] ?? " "
                    let picture = jj?["picture"] ?? " "
                    let name = jj?["name"] ?? " "
                    let token = jj?["token"] ?? " "
                    UserDefaults.standard.set(found, forKey: "found")
                    UserDefaults.standard.set(userId, forKey: "userId")
                    UserDefaults.standard.set(picture, forKey: "picture")
                    UserDefaults.standard.set(name, forKey: "name")
                    UserDefaults.standard.set(token, forKey: "token")
                    if(found == "found")
                    {
                        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "homepage") as? HomePageControllerViewController
                        secondVC!.modalPresentationStyle = .fullScreen
                        self.present(secondVC!, animated: true, completion: nil)
                    }
                        
                    else {
                        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "setall") as? AllSetViewController
                        secondVC!.modalPresentationStyle = .fullScreen
                        self.present(secondVC!, animated: true, completion: nil)
                    }
                    
                    
              
            }
        }
        }
        else{
            self.present(Alert.makeAlert(titre: "Error", message: "Your OPT doesn't match. Check it again!"),animated: true)
        }
    }
    
}
