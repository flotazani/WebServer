//
//  Extensions.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 01.03.2021.
//

import Foundation
import UIKit
extension UIViewController {


    func showAlert(message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }




}
