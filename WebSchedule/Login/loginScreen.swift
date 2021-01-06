//
//  loginScreen.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 19.12.2020.
//

import Foundation
import UIKit

class LogSignViewController: UIViewController {

    var manager = NetworkManager()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!


    @IBAction func loginButtonClick(_ sender: Any) {
        manager.login(name: "NatanTheChef", password: "qwerty") { user, error in
            if user != nil{
                print(user!)
            } else {
                print(error)
            }
        }
    }

    @IBAction func SignUpButtonClick(_ sender: Any) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
