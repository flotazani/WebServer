//
//  JSONEncoding.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/05.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            var tempParams = Parameters()
            for (key,value) in parameters {
                if let user = value as? userModel {
                    let js = try JSONEncoder().encode(user)
                    let serialized = try JSONSerialization.jsonObject(with: js, options: []) as? [String: Any]

                    tempParams[key] = serialized

                } else if value is String{
                    tempParams[key] = value
                }
            }
            let jsonAsData = try JSONSerialization.data(withJSONObject: tempParams, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData

            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}

