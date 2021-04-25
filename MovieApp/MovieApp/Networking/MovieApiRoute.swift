//
//  MovieApiRoute.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 20/04/21.
//

import Foundation

protocol URLComponentsRepresentable {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? {get}
}

extension URLComponentsRepresentable {
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents
    }
    
    var url: URL? {
        return urlComponents.url
    }
}

enum MovieApiRoute {
    case home(pageNo: Int)
    case synoypsis(movieId: String)
    case reviews(movieId: String, pageNo: Int)
    case credits(movieId: String)
    case similar(movieId: String, pageNo: Int)
    case search(query: String, pageNo: Int)
}

extension MovieApiRoute: URLComponentsRepresentable {
    
    var scheme: String {
        "https"
    }
    
    var host: String {
        Environment.serverEndPoint
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .home(let pageNo):
            var queryParam: [URLQueryItem] = []
            queryParam.append(URLQueryItem(name: "api_key", value: Environment.apiKey))
            queryParam.append(URLQueryItem(name: "page", value: String(pageNo)))
            return queryParam
        case .synoypsis(_):
            var queryParam: [URLQueryItem] = []
            queryParam.append(URLQueryItem(name: "api_key", value: Environment.apiKey))
            return queryParam
        case .reviews(_, let pageNo):
            var queryParam: [URLQueryItem] = []
            queryParam.append(URLQueryItem(name: "api_key", value: Environment.apiKey))
            queryParam.append(URLQueryItem(name: "page", value: String(pageNo)))
            return queryParam
        case .credits(_):
            var queryParam: [URLQueryItem] = []
            queryParam.append(URLQueryItem(name: "api_key", value: Environment.apiKey))
            return queryParam
        case .similar(_, let pageNo):
            var queryParam: [URLQueryItem] = []
            queryParam.append(URLQueryItem(name: "api_key", value: Environment.apiKey))
            queryParam.append(URLQueryItem(name: "page", value: String(pageNo)))
            return queryParam
        case .search(let query, let pageNo):
            var queryParam: [URLQueryItem] = []
            queryParam.append(URLQueryItem(name: "api_key", value: Environment.apiKey))
            queryParam.append(URLQueryItem(name: "page", value: String(pageNo)))
            queryParam.append(URLQueryItem(name: "query", value: query))
            return queryParam
        }
    }
    
    var path: String {
        let basePath = "/\(Environment.apiVersion)"
        switch self {
        case .home(_):
            return "\(basePath)/movie/now_playing"
        case .synoypsis(let movieId):
            return "\(basePath)/movie/\(movieId)"
        case .reviews(let movieId, _):
            return "\(basePath)/movie/\(movieId)/reviews"
        case .credits(let movieId):
            return "\(basePath)/movie/\(movieId)/credits"
        case .similar(let movieId, _):
            return "\(basePath)/movie/\(movieId)/similar"
        case .search:
            return "\(basePath)/search/movie"
        }
    }
}
