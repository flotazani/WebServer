//
//  NotesEndPoint.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 25.02.2021.
//

import Foundation

public enum NoteEndPoint {

    case getNotes(token: String)
    case createNote(token: String, user: userModel,  body: String)
    case deleteNote(token: String, user: userModel,  id: String)
    case updateNote(token: String, id: String, user: userModel, body: String )
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
        case .getNotes:
            return "/notes/get"
        case .createNote:
            return "/notes/create"
        case .deleteNote:
            return "/notes/delete"
        case .updateNote:
            return "/notes/update"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getNotes:
            return .get
        case .createNote:
            return .post
        case .deleteNote:
            return .delete
        case .updateNote:
            return .post
        }
    }

    var task: HTTPTask {
        switch self {

        case .getNotes:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                bodyEncoding: .jsonEncoding,
                                                additionHeaders: headers)
        case .createNote:
            return .requestParametersAndHeaders(bodyParameters: notesParameters,
                                                bodyEncoding: .jsonEncoding,
                                                additionHeaders: headers)
        case .deleteNote:
            return .requestParametersAndHeaders(bodyParameters: notesParameters,
                                                bodyEncoding: .jsonEncoding,
                                                additionHeaders: headers)
        case .updateNote:
            return .requestParametersAndHeaders(bodyParameters: notesParameters,
                                                bodyEncoding: .jsonEncoding,
                                                additionHeaders: headers)
        default:
            return .request
        }
    }

    private var notesParameters: [String: Any]? {
        switch self {
        case .getNotes:
            return nil
        case .createNote( _, let user, let body):
            return [NotesParameterKeys.user: user, NotesParameterKeys.body: body]
        case .deleteNote( _, let user, let id):
            return [NotesParameterKeys.user: user, NotesParameterKeys.noteId: id]
        case .updateNote( _, let id, let user, let body):
            return [NotesParameterKeys.noteId: id, NotesParameterKeys.user: user, NotesParameterKeys.body: body ]
        }
    }



    var headers: HTTPHeaders? {
        switch self {
        case .getNotes(let token):
            return ["Authorization" : "Bearer \(token)"]
        case .createNote(let token, _, _):
            return ["Authorization" : "Bearer \(token)"]
        case .deleteNote(let token, _, _):
            return ["Authorization" : "Bearer \(token)"]
        case .updateNote(let token, _, _, _):
            return ["Authorization" : "Bearer \(token)"]
        }
    }
}


