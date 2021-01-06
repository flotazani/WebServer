//
//  MovieEndPoint.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/07.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public enum AuthEndPoint {

    case login(name: String, password: String)
    case logout(token: String)
    case signup(name: String, password: String)
    case me(token: String)
}

extension AuthEndPoint: EndPointType {

    var environmentBaseURL : String {
        return "http://127.0.0.1:8080"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String{
        switch self {
        case .login:
            return "/users/login"
        case .logout:
            return "/users/logout"
        case .me:
            return "/users/me"
        case .signup:
            return "/users/signup"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .logout:
            return .post
        case .me:
            return .get
        case .signup:
            return .post
        }
    }

    var task: HTTPTask {
        switch self {

        case .login:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                bodyEncoding: .jsonEncoding,
                                                additionHeaders: headers)
        case .logout:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                bodyEncoding: .jsonEncoding,
                                                additionHeaders: headers)
        case .me:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                bodyEncoding: .jsonEncoding,
                                                additionHeaders: headers)
        case .signup:
            return .requestParametersAndHeaders(bodyParameters: parameters,
                                                bodyEncoding: .jsonEncoding)
        default:
        return .request
    }
}

    private var parameters: [String: String]? {
        switch self {
        case .login:
            return nil
        case .logout:
            return nil
        case .me:
            return nil
        case .signup(let name, let password):
            return [APIParameterKeys.userName: name, APIParameterKeys.password: password ]
        }
    }
    

    
    var headers: HTTPHeaders? {
        switch self {
        case .login(let name, let password):
            let authString = "\(name):\(password)".data(using: String.Encoding.utf8)!.base64EncodedString()
            return ["Authorization" : "Basic \(authString)"]
        case .logout(let token):
            return ["Authorization" : "Bearer \(token)"]
        case .me(let token):
            return ["Authorization" : "Bearer \(token)"]
        case .signup:
            return nil
        }
    }
}


struct APIParameterKeysAuth{

    static let userName = "username"
    static let password = "password"
    static let contentType = "Content-Type"
}
