//
//  NotesViewController.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 25.02.2021.
//

import UIKit

class NotesViewController: UITableViewController {

    private var model: notesModel?
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
                }
                self.model = data
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

    

    private func deleteNote(with id: String, user: userModel){
        guard let token = token else {
            return
        }

        NetworkManager.shared.deleteNote(token: token, user: user, id: id) { result in
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

    @objc func addNote(){
        let noteViewController:NoteViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController
        noteViewController.onSavePressed = { note in
            self.model?.notes.insert(note, at: 0)
        }
        noteViewController.note?.id = model?.notes.first?.id ?? ""
        noteViewController.note?.user = (model?.notes.first?.user)!

        self.navigationController?.pushViewController(noteViewController, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.notes.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        cell.textLabel?.text = model?.notes[indexPath.row].body
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let user = model?.notes[indexPath.row].user, let id = model?.notes[indexPath.row].id else {
                return
            }

            tableView.deleteRows(at: [indexPath], with: .fade)
            deleteNote(with: id, user: user)
        } 
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let index = index else {
            return
        }
        let destinationVC = segue.destination as! NoteViewController
        destinationVC.note = (model?.notes[index])!
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
