//
//  ProfileViewController.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 25.02.2021.
//

import UIKit

class ProfileViewController: UIViewController {


    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!


    private var child = SpinnerViewController()
    private let token = UserDefaults.standard.string(forKey: "userToken")
    private var data: userModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
    }
    

    private func getUserData() {
        guard let token = token else {
            return
        }
        setSpiner()
        NetworkManager.shared.me(token: token) { result in
            switch result {
            case .success(let data):
                self.data = data
                self.setUpScreen()
                DispatchQueue.main.async {
                    self.removeSpinner()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.removeSpinner()
                }
                DispatchQueue.main.async {
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }
    }

    private func setUpScreen(){
        DispatchQueue.main.async {
            guard let data = self.data else {
                return
            }
            self.userNameLabel.text = data.username
            self.creationDateLabel.text = data.createdAt
        }
    }

    
    @IBAction func logOutTapped(_ sender: Any) {
        guard let token = token else {
            return
        }
        NetworkManager.shared.logout(token: token) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    UserDefaults.standard.removeObject(forKey: "userToken")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let loginNavController = storyboard.instantiateViewController(identifier: "LoginViewController")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(message: error.localizedDescription)
                }
            }
            
        }
    }

    func setSpiner(){
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func removeSpinner(){
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
