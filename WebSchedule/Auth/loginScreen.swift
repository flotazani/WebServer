//
//  loginScreen.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 19.12.2020.
//

import Foundation
import UIKit

class LogSignViewController: BasicViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!


    @IBAction func loginButtonClick(_ sender: Any) {

        guard let name = nameTextField.text, let password = passwordTextField.text else {
            showAlert(message: "enter creds!!")
            return
        }

        manager.login(name: name, password: password) { result in
            switch result {
            case .success(let data):
                UserDefaults.standard.set(data.token, forKey: "userToken")
                print(data)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


//        guard let token = token else {
//            return
//        }
//        manager.logout(token: token) { result in
//            switch result {
//            case .success(let data):
//                print(data)
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.showAlert(message: error.localizedDescription)
//                }
//            }
//        }
