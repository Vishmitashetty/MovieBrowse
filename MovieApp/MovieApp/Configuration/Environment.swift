//
//  Environment.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 20/04/21.
//

import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let serverEndPoint = "SERVER_END_POINT"
            static let apiKey = "API_KEY"
            static let apiVersion = "API_VERSION"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    // MARK: - Plist values
    static let serverEndPoint: String = {
        guard let serverEndPoint = Environment.infoDictionary[Keys.Plist.serverEndPoint] as? String else {
            fatalError("serverEndPoint not set in plist for this environment")
        }
        return serverEndPoint
    }()
    
    static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary[Keys.Plist.apiKey] as? String else {
            fatalError("apiKey not set in plist for this environment")
        }
        return apiKey
    }()
    
    static let apiVersion: String = {
        guard let apiVersion = Environment.infoDictionary[Keys.Plist.apiVersion] as? String else {
            fatalError("serverBaseKey not set in plist for this environment")
        }
        return apiVersion
    }()
}
