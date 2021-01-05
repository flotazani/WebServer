//
//  EndPointsContsructor.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 19.12.2020.
//

import Foundation
/*
enum APIRouter {
   


    private var method: HTTPMethod {
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

    private var path: String{
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

    private var baseURL: URL{
        return URL(string: "http://127.0.0.1:8080")!
    }


    func asURLRequest() throws -> URLRequest {

        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        let parameters = self.parameters
        if parameters != nil {

            //TODO:- create body parameters string if neccessary based on request

            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters,
                                                             options: .prettyPrinted)
        }
        return urlRequest
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

 */
