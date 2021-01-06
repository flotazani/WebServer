//
//  BasicUIView.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 06.01.2021.
//

import Foundation
import UIKit

public class BasicViewController: UIViewController {
    var manager = NetworkManager()


    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    public func showAlert(message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}
