//
//  SignUpScreen.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 06.01.2021.
//

import Foundation
import UIKit

class SignUpViewController: BasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var userNameTextField: UITextField!

    @IBOutlet weak var userPasswordTextField: UITextField!


    @IBAction func SingUpButtonClicked(_ sender: Any) {
        guard let name = userNameTextField.text, let password = userPasswordTextField.text else {
            showAlert(message: "enter creds!!")
            return
        }
        manager.signup(name: name, password: password) { result in
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


}
