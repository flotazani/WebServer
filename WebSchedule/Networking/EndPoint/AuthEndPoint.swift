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
            return "/login"
        case .logout:
            return "/logout"
        case .me:
            return "/me"
        case .signup:
            return "signup"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .me:
            return .get
        case .login:
            return .post
        case .logout:
            return .post
        case .signup:
            return .post
        }
    }

    private var parameters: [String: String]? {
        switch self {
        case .login(let name, let password):
            return [APIParameterKeys.userName: name,APIParameterKeys.password: password ]
        case .logout:
            return nil
        case .me:
            return nil
        case .signup(let name, let password):
            return [APIParameterKeys.userName: name,APIParameterKeys.password: password ]
        }
    }
    
//    var task: HTTPTask {
//        switch self {
//
//        case .login:
//            return .requestParametersAndHeaders(bodyParameters: parameters,
//                                      bodyEncoding: .,
//                                      urlParameters: ["page":page,
//                                                      "api_key":NetworkManager.MovieAPIKey])
//        case .logout:
//            return .requestParametersAndHeaders(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: ["page":page,
//                                                      "api_key":NetworkManager.MovieAPIKey])
//        case .me:
//            return .requestParametersAndHeaders(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: ["page":page,
//                                                      "api_key":NetworkManager.MovieAPIKey])
//        case .signup:
//            return .requestParametersAndHeaders(bodyParameters: nil,
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: ["page":page,
//                                                      "api_key":NetworkManager.MovieAPIKey])
//        }
//        default:
//            return .request
//        }
//    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .me:
            return .re
        case .login:
            return .post
        case .logout:
            return .post
        case .signup:
            return .post
        }
    }
}


struct APIParameterKeysAuth{

    static let userName = "username"
    static let password = "password"
    static let contentType = "Content-Type"
}
