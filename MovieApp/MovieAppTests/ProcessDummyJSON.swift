//
//  ProcessDummyJSON.swift
//  MovieAppTests
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation
@testable import MovieApp

class ProcessDummyJSON {
    
    static let sharedObject = ProcessDummyJSON()
    private init() {}
    
    func processJSONResponse<T: Codable>(path: String?, completionHandler: @escaping (Result<T, TaskError>) -> Void) {
        if let path = path {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let jsonObject = try decoder.decode(T.self, from: jsonData)
                    completionHandler(.success(jsonObject, 200))
                } catch {
                    print(error.localizedDescription)
                    completionHandler(.failure(.jsonError, 500))
                    return
                }
            } catch {
                // handle error
            }
        }
    }
}
