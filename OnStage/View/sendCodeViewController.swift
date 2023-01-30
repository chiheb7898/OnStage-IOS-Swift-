//
//  sendCodeViewController.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 07/05/2022.
//

import UIKit

class sendCodeViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    var code : String = ""
    var email1 : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func OPTbtn(_ sender: Any) {
        guard let email = self.email.text else {return}
        
        UserViewModel.sharedInstance.callingSendCodeAPI(email: email){ [self]
            (isSuccess,str) in
            if isSuccess{
               
                UserDefaults.standard.set(str, forKey: "code")
                UserDefaults.standard.set(email, forKey: "email")

               
            }
        }
        performSegue(withIdentifier: "VerifCodeSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "VerifCodeSegue"{
            //let indexPath = sender as! IndexPath
            let destination = segue.destination as? verifCodeViewController
          
            
        }
    }
    
}
