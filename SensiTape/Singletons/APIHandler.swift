//
//  APIHandler.swift
//  Sensi-Tape
//
//  Created by Peyton McKee on 10/8/23.
//

import Foundation

class APIHandler {
    static let shared = APIHandler()
    
    /**
     * Generic Query Function for Retrieving data from the backend
     * @param urlEndpoint The route endpoint to ping for data
     * @param completion The completion handler to call when the data is retrieved
     */
     public func queryData <T : Codable>(route: String, completion: @escaping (Result<T, Error>) -> Void) {
        let request = URL(string: route)!
        URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                //If the response status code is not 200 decode the response as an error and complete with the constructed error
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    let errorResponse = try decoder.decode(HttpError.self, from: data)
                    print(errorResponse)
                    let error = NSError(domain: "HTTPError", code: errorResponse.status, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
                    completion(.failure(error))
                    return
                }
                
                let item = try decoder.decode(T.self, from: data)
                completion(.success(item))
            } catch {
                completion(.failure(error))
            }
        }).resume()
    }
    
    /**
     * Mutates values in the backend by calling a post endpoint and passing in the requeired data
     * @param route The route that the request will be pinging
     * @param data The data you are encoding into the request body
     * @param completion The result of the request, either a success message or an error
     */
    public func mutateData <T : Codable>(route: String, data: T, completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: route)!
        
        let encoder = JSONEncoder()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? encoder.encode(data)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    let errorResponse = try decoder.decode(HttpError.self, from: data)
                    let error = NSError(domain: "HTTPError", code: errorResponse.status, userInfo: [NSLocalizedDescriptionKey: errorResponse.message])
                    completion(.failure(error))
                    return
                }
                
                completion(.success("Successfully Updated Object"))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
