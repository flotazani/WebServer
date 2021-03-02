//
//  LoginModel.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 05.01.2021.
//

import Foundation


struct signModel: Codable {

    let token: String
    let user: userModel
}

public struct userModel: Codable {

    let username: String?
    let id: String
    let updatedAt: String?
    let createdAt: String?
}

struct notesModel: Codable {
    var notes: [noteModel]
}

struct noteModel: Codable {
    var id: String
    var user: userModel
    let body: String
}
struct ErrorModel: Codable {
    let error: Double? = nil
    let reason: String?
}



struct APIParameterKeys {
    static let userName = "username"
    static let password = "password"
    static let contentType = "Content-type"
}

struct NotesParameterKeys {
    static let user = "user"
    static let body = "body"
    static let noteId = "id"
}


