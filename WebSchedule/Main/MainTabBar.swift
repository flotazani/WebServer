//
//  MainTabBar.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 25.02.2021.
//

import UIKit

class MainTabBar: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
    }

    private func getUserData() {
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            return
        }

            NetworkManager.shared.getNotes(token: token, completion: <#(Result<notesModel, Error>) -> Void#>)

         { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }

        NetworkManager.shared.me(token: token) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }
    }


    public func showAlert(message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}
