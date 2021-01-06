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

    let username: String
    let id: String
    let updatedAt: String
    let createdAt: String
}

struct ErrorModel{
    let error: Int?
    let reason: String?
}



struct APIParameterKeys {
    static let userName = "username"
    static let password = "password"
    static let contentType = "Content-type"
}


