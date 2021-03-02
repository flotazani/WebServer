//
//  SpinnerView.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 01.03.2021.
//

import UIKit
class SpinnerViewController: UIViewController {

    override func loadView() {
        var spinner = UIActivityIndicatorView(style: .large)
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        spinner.color = .red
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
