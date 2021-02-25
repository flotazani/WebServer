//
//  PersonalViewController.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 06.01.2021.
//

import UIKit

class PersonalViewController: BasicViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutTapped(_ sender: UIButton) {
        // ...
        // after user has successfully logged out

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
    }
}
