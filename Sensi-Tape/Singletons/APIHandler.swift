//
//  APIHandler.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/8/23.
//

import Foundation

class APIHandler {
    static let baseURL = "http://localhost:8080"
    
    static func getAllUsers (completion: @escaping (Result<[User], Error>) -> Void) {
        let request = URL(string: "\(Self.baseURL)/users")!
        URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            let decoder = JSONDecoder()
            do {
                let users = try decoder.decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }).resume()
    }
}
