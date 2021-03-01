//
//  NoteViewController.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 25.02.2021.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updateNote))
        // Do any additional setup after loading the view.
    }

    @objc func updateNote(){

    }

}
