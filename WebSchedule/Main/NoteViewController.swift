//
//  NoteViewController.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 25.02.2021.
//

import UIKit

class NoteViewController: UIViewController {

    var note: noteModel?
    let token = UserDefaults.standard.string(forKey: "userToken")
    var onSavePressed: ((noteModel) -> Void)?
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updateNote))
    }

    @objc func updateNote(){
        guard let note = note, let token = token else {
            return
        }
        onSavePressed?(note)
        NetworkManager.shared.createNote(token: token, user: note.user, body: note.body){ result in
            switch result {
            case .success(_):
                print(" ")
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }
    }

    
}
