//
//  Alert.swift
//  OnStage
//
//  Created by Chiheb-4SIM3 on 20/04/2022.
//

import Foundation
import UIKit


class Alert{
    static func makeAlert(titre: String?, message: String?) -> UIAlertController {
            let alert = UIAlertController(title: titre, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            return alert
        }
        
        static func makeActionAlert(titre: String?, message: String?, action: UIAlertAction) -> UIAlertController {
            let alert = UIAlertController(title: titre, message: message, preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
            alert.addAction(actionOk)
            alert.addAction(action)
            return(alert)
        }
}
