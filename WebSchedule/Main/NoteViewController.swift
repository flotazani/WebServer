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
    private var onTextChanged: ((String) -> Void)?
    var isCreate: Bool?

    var onSavePressed: ((noteModel) -> Void)?
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(updateNote))
        onTextChanged = { string in
            self.note?.body = string
        }
        textView.delegate = self

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let text = note?.body else {
            return
        }
        textView.text = text

    }

    @objc func updateNote(){
        guard let note = note, let token = token, !note.body.isEmpty, let isCreate = isCreate else {
            return
        }
        if isCreate {
            NetworkManager.shared.createNote(token: token, user: note.user, body: note.body){ result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.onSavePressed?(note)
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert(message: error.localizedDescription)
                    }
                }
            }
        } else {
            NetworkManager.shared.updateNote(token: token,
                                             id: note.id,
                                             user: note.user,
                                             body: note.body) {  result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.onSavePressed?(note)
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert(message: error.localizedDescription)
                    }
                }
            }
        }
    }
}

 extension NoteViewController: UITextViewDelegate {

     func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        onTextChanged?(updatedText)
        return true
    }
}
