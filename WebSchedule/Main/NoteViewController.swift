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
        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem(image: UIImage(named: "backBtn"), style: .plain, target: self, action: nil)
            //UIBarButtonItem(barButtonSystemItem: ., target: self, action: #selector(updateNote))
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            // Your code...
        }
    }

    @objc func updateNote(){
        print("hha")
    }

}
