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

struct userModel: Codable {

    let username: String?
    let id: String
    let updatedAt: String?
    let createdAt: String?
}

struct notesModel: Codable {
    let notes: [noteModel]
}

struct noteModel: Codable {
    let id: String
    let user: userModel
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


