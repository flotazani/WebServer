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
        NetworkManager.shared.signup(name: name, password: password) { result in
            switch result {
            case .success(let data):
                UserDefaults.standard.set(data.token, forKey: "userToken")
                self.singUpSucced()
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }
    }

    private func singUpSucced() {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }


}
