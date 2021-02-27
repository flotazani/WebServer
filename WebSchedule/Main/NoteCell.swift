//
//  File.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 27.02.2021.
//

import Foundation
import UIKit

final class NoteCell: UITableViewCell {


    @IBOutlet weak var textField: UITextField!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textField.font = .systemFont(ofSize: 34)

    }


}
