//
//  HTTPTask.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 20/04/21.
//

import Foundation

// Add HTTPTaskProtocol to HTTPTask. Any new addition should be added to protocol so test cases can work as expected
protocol HTTPTaskProtocol {
        func GET<T: Codable>(api: URLComponentsRepresentable, config: URLSessionConfiguration?, completionHandler: @escaping (Result<T, TaskError>) -> Void )
        func POST<T: Codable, U: Codable>(api: URLComponentsRepresentable, jsonBody: U?, contentType: ContentType, config: URLSessionConfiguration?, completionHandler: @escaping (Result<T, TaskError>) -> Void )
        func PUT<T: Codable, U: Codable>(api: URLComponentsRepresentable, jsonBody: U?, contentType: ContentType, config: URLSessionConfiguration?, completionHandler: @escaping (Result<T, TaskError>) -> Void )
        func UPDATE<T: Codable, U: Codable>(api: URLComponentsRepresentable, jsonBody: U?, contentType: ContentType, config: URLSessionConfiguration?, completionHandler: @escaping (Result<T, TaskError>) -> Void )
        func DELETE<T: Codable>(api: URLComponentsRepresentable, config: URLSessionConfiguration?, completionHandler: @escaping (Result<T, TaskError>) -> Void )
        func sendRequest<T: Codable>(_ url: URL, method: String, _ data: Data?, contentType: ContentType, sessionConfig: URLSessionConfiguration?, _ completionHandler: @escaping (Result<T, TaskError>) -> Void)
}

enum TaskError: Error {
    case httpError(code: String)
    case jsonError
    case noData
    case other
}

enum Result<T, TaskError> {
    case success(T, Int?)
    case failure(TaskError, Int?)
}

enum ContentType: String {
    case json = "application/json"
    case text = "text/plain"
}

class HTTPTask: NSObject, HTTPTaskProtocol {
    
    func GET<T: Codable>(api: URLComponentsRepresentable,
                         config: URLSessionConfiguration? = nil,
                         completionHandler: @escaping (Result<T, TaskError>) -> Void ) {
        guard let url = api.url else {
            completionHandler(.failure(.other, nil))
            return
        }
        sendRequest(url, method: "GET", nil, completionHandler)
    }

    func POST<T: Codable, U: Codable>(api: URLComponentsRepresentable,
                                      jsonBody: U? = nil,
                                      contentType: ContentType = .json,
                                      config: URLSessionConfiguration? = nil,
                                      completionHandler: @escaping (Result<T, TaskError>) -> Void ) {
        guard let url = api.url else {
            completionHandler(.failure(.other, nil))
            return
        }
        var jsonBodyData: Data?
        if let body = jsonBody {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(body)
            jsonBodyData = data
        }
        sendRequest(url, method: "POST", jsonBodyData, contentType: contentType, completionHandler)
    }

    func PUT<T: Codable, U: Codable>(api: URLComponentsRepresentable, jsonBody: U? = nil, contentType: ContentType = .json, config: URLSessionConfiguration? = nil, completionHandler: @escaping (Result<T, TaskError>) -> Void ) {
        guard let url = api.url else {
            completionHandler(.failure(.other, nil))
            return
        }
        var jsonBodyData: Data?
        if let body = jsonBody {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(body)
            jsonBodyData = data
        }
        sendRequest(url, method: "PUT", jsonBodyData, contentType: contentType, completionHandler)
    }

    func UPDATE<T: Codable, U: Codable>(api: URLComponentsRepresentable, jsonBody: U? = nil, contentType: ContentType = .json, config: URLSessionConfiguration? = nil, completionHandler: @escaping (Result<T, TaskError>) -> Void ) {
        guard let url = api.url else {
            completionHandler(.failure(.other, nil))
            return
        }
        var jsonBodyData: Data?
        if let body = jsonBody {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(body)
            jsonBodyData = data
        }
        sendRequest(url, method: "PUT", jsonBodyData, contentType: contentType, completionHandler)
    }

    func DELETE<T: Codable>(api: URLComponentsRepresentable,
                            config: URLSessionConfiguration? = nil, completionHandler: @escaping (Result<T, TaskError>) -> Void ) {
        guard let url = api.url else {
            completionHandler(.failure(.other, nil))
            return
        }
        sendRequest(url, method: "DELETE", nil, completionHandler)
    }

    func sendRequest<T: Codable>(_ url: URL, method: String, _ data: Data?, contentType: ContentType = .json, sessionConfig: URLSessionConfiguration? = nil, _ completionHandler: @escaping (Result<T, TaskError>) -> Void) {

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method

        if let data = data {
            urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = data
        }
        
        LoggerRepository.shared.apiDebugging(url: url.absoluteString, method: method)
        let session = URLSession.init(configuration: .default, delegate: nil, delegateQueue: nil)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {return}

            if error != nil {
                LoggerRepository.shared.apiResponseFailure(url: url.absoluteString, method: method, message: error?.localizedDescription)
                completionHandler(.failure(.other, statusCode))
                return
            }

            guard let jsonData = data, !jsonData.isEmpty else {
                LoggerRepository.shared.apiResponseFailure(url: url.absoluteString, method: method, message: "JSON is empty")
                completionHandler(.failure(.noData, statusCode))
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let jsonObject = try? decoder.decode(T.self, from: jsonData) else {
                LoggerRepository.shared.apiResponseFailure(url: url.absoluteString, method: method, message: "JSON error")
                completionHandler(.failure(.jsonError, statusCode))
                return
            }
            LoggerRepository.shared.apiResponseSuccess(url: url.absoluteString, method: method, message: "API Executed successfully")
            completionHandler(.success(jsonObject, statusCode))
        }
        task.resume()
    }
    
}
