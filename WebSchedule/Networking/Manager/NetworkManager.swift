//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/11.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

enum NetworkResponse: Error {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
}

public class NetworkManager {
    static let MovieAPIKey = ""
    let router = Router<AuthEndPoint>()
    let routerNotes = Router<NoteEndPoint>()

    func login(name: String, password: String, completion: @escaping (Result<signModel, Error>) -> Void) {
        router.request(.login(name: name, password: password)) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                self.getResult(result, data) { res in
                    completion(res)
                }
            }
        }
    }

    func signup(name: String, password: String, completion: @escaping (Result<signModel, Error>) -> Void) {
        router.request(.signup(name: name, password: password)) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                self.getResult(result, data) { res in
                    completion(res)
                }
            }
        }
    }

    func logout(token: String, completion: @escaping (Result<String, Error>) -> Void) {
        router.request(.logout(token: token)){ data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                completion(result)
            }
        }
    }

    func me(token: String, completion: @escaping (Result<userModel, Error>) -> Void) {
        router.request(.me(token: token)) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                self.getResult(result, data) { res in
                    completion(res)
                }
            }
        }
    }

    func getNotes(token: String, completion: @escaping (Result<notesModel, Error>) -> Void){
        routerNotes.request(.getNotes(token: token)) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                self.getResult(result, data) { res in
                    completion(res)
                }
            }
        }
    }

    func createNote(token: String, user: userModel, body: String,  completion: @escaping (Result<String, Error>) -> Void){
        routerNotes.request(.createNote(token: token, user: user, body: body)) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                completion(result)
            }
        }
    }

    func deleteNote(token: String, user: userModel, id: String, completion: @escaping (Result<String, Error>) -> Void){
        routerNotes.request(.deleteNote(token: token, user: user, id: id)) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                completion(result)
            }
        }
    }

    func updateNote(token: String, id: String, user: userModel, body: String, completion: @escaping (Result<String, Error>) -> Void){
        routerNotes.request(.updateNote(token: token, id: id, user: user, body: body)) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                completion(result)
            }
        }
    }

    public func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String,Error>{
        switch response.statusCode {
        case 200...299: return .success("OK")
        case 401...500: return .failure(NetworkResponse.authenticationError)
        case 501...599: return .failure(NetworkResponse.badRequest)
        case 600: return .failure(NetworkResponse.outdated)
        default: return .failure(NetworkResponse.failed)
        }
    }


    private func decode<T: Codable>(_ data: Data?) throws -> Result<T,Error> {

        guard let responseData = data else {
            return .failure(NetworkResponse.noData)
        }
        print(responseData)
        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
        print(jsonData)
        let apiResponse = try JSONDecoder().decode(T.self , from: responseData)
        return .success(apiResponse)
    }

    private func getResult<T: Codable>(_ result: Result<String, Error>,
                                       _ data: Data?,
                                       completion: @escaping (Result<T, Error>) -> Void) {
        switch result {
        case .success:
            do {
                let apiResponseResult: Result<T, Error> = try self.decode(data)
                completion(apiResponseResult)
            }catch {
                print(error)
                completion(.failure(NetworkResponse.unableToDecode))
            }
        case .failure:
            do {
                let apiErrorResult: Result<ErrorModel?, Error> = try self.decode(data)
                completion(.failure(try apiErrorResult.get()?.reason as! Error ))
            } catch {
                print(error)
                completion(.failure(NetworkResponse.unableToDecode))
            }
        }
    }
}
