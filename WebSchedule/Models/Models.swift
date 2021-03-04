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

    var username: String?
    var id: String
    var updatedAt: String?
    var createdAt: String?

    init(username: String?, id: String, updatedAt: String?, createdAt: String?){
        self.username = username
        self.id = id
        self.updatedAt = updatedAt
        self.createdAt = createdAt
    }
}

struct noteModel: Codable {
    var id: String
    var user: userModel
    var body: String

    init(id: String, user: userModel, body: String){
        self.id = id
        self.user = user
        self.body = body
    }
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


