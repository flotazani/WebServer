//
//  NotesEndPoint.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 25.02.2021.
//

import Foundation
public enum NoteEndPoint {

    case get(name: String, password: String)
    case create(token: String)
    case delete(name: String, password: String)
    case update(token: String)
}

extension NoteEndPoint: EndPointType {

    var environmentBaseURL : String {
        return "http://127.0.0.1:8080"
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String{
        switch self {
        case .get:
            return "/notes/get"
        case .create:
            return "/notes/create"
        case .delete:
            return "/notes/delete"
        case .update:
            return "/notes/update"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .create:
            return .post
        case .delete:
            return .delete
        case .update:
            return .post
        }
    }

    var task: HTTPTask {
        switch self {

        case .get:
            return .requestParametersAndHeaders(bodyParameters: parameters,
                                                bodyEncoding: .jsonEncoding,
                                                additionHeaders: headers)
        case .create:
            return .requestParametersAndHeaders(bodyParameters: parameters,
                                                bodyEncoding: .jsonEncoding,
                                                additionHeaders: headers)
        case .delete:
            return .requestParametersAndHeaders(bodyParameters: parameters,
                                                bodyEncoding: .jsonEncoding,
                                                additionHeaders: headers)
        case .update:
            return .requestParametersAndHeaders(bodyParameters: parameters,
                                                bodyEncoding: .jsonEncoding,
                                                additionHeaders: headers)
        default:
            return .request
        }
    }

    private var parameters: [String: String]? {
        switch self {
        case .get:
            return nil
        case .create(let user, let body):
            return [NotesParameterKeys.name: user, NotesParameterKeys.body: body]
        case .delete(let user, let id):
            return [NotesParameterKeys.user: user, NotesParameterKeys.noteId: id]
        case .update(let id, let body ):
            return [APIParameterKeys.noteId: id, APIParameterKeys.body: body ]
        }
    }



    var headers: HTTPHeaders? {
        switch self {
        case .get(let token):
            return ["Authorization" : "Bearer \(token)"]
        case .create(let token):
            return ["Authorization" : "Bearer \(token)"]
        case .delete(let token):
            return ["Authorization" : "Bearer \(token)"]
        case .update(let token):
            return ["Authorization" : "Bearer \(token)"]
        }
    }
}


