//
//  NotesViewController.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 25.02.2021.
//

import UIKit

class NotesViewController: UITableViewController {

    private var model: [noteModel]?
    private var user: userModel?
    private let token = UserDefaults.standard.string(forKey: "userToken")
    private var index: Int?
    private var child: SpinnerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        getUserData()
        child = SpinnerViewController()
    }


    private func getUserData() {
        guard let token = token else {
            return
        }
        setSpiner()


        NetworkManager.shared.getNotes(token: token) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.removeSpinner()
                    self.model = data
                    self.tableView.reloadData()
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.removeSpinner()
                    if error.localizedDescription != "No data found" {
                        self.showAlert(message: error.localizedDescription)
                    }
                }
            }
        }
        NetworkManager.shared.me(token: token) { result in
            switch result {
            case .success(let data):
                self.user = data
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

    private func deleteNote(with id: String, user: userModel, index: IndexPath){
        guard let token = token else {
            return
        }

        NetworkManager.shared.deleteNote(token: token, user: user, id: id) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.model?.remove(at: index.row)
                    self.tableView.deleteRows(at: [index], with: .fade)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }
    }

    @objc func addNote(){
        let noteViewController:NoteViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController

        noteViewController.onSavePressed = { note in
            self.model?.insert(note, at: 0)
            self.tableView.reloadData()
        }

         guard let user = user else {
            return
         }

        noteViewController.note = noteModel(id: "", user: user, body: "")
        noteViewController.isCreate = true
        self.navigationController?.pushViewController(noteViewController, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = model?[indexPath.row].body
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let user = model?[indexPath.row].user, let id = model?[indexPath.row].id else {
                return
            }
            deleteNote(with: id, user: user, index:  indexPath)
        } 
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        self.tableView.deselectRow(at: indexPath, animated: true)
        editNote()
    }

    func editNote(){
        if let ind = index {

            let noteViewController:NoteViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController

            noteViewController.onSavePressed = { note in
                self.model?[ind].body = note.body
                self.tableView.reloadData()
            }

            guard let id =  model?[ind].id, let user = self.model?[ind].user, let body = model?[ind].body else {
                return
            }
            let note = noteModel(id: id, user: user, body: body)
            noteViewController.note = note
            noteViewController.isCreate = false
            self.navigationController?.pushViewController(noteViewController, animated: true)

        }

    }

    func setSpiner(){
        guard let child = child else {
            return
        }
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func removeSpinner(){
        guard let child = child else {
            return
        }
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }

}
