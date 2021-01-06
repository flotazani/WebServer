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
    var token: String?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!


    @IBAction func loginButtonClick(_ sender: Any) {
        guard let token = token else {
            return
        }
        manager.logout(token: token) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func SignUpButtonClick(_ sender: Any) {
        manager.login(name: "bob dolbaeb", password: "aaa22bb") { result in
            switch result {
            case .success(let data):
                self.token = data?.token
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
