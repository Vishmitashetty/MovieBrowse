//
//  Logging.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 27/04/21.
//

import os.log
import Foundation

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let networkCategory = Logger(subsystem: subsystem, category: "apiResponse")
    static let dbCategory = Logger(subsystem: subsystem, category: "dbOperations")
    
    //MARK: - Network leyer logging
    static func apiResponseSuccess(url: String, method: String, message: String?) {
        Logger.networkCategory.info("\(method): API response success for \(url) with \(message ?? "")")
    }
    
    static func apiResponseFailure(url: String, method: String, message: String?) {
        Logger.networkCategory.error("\(method): API response failed for \(url) with \(message ?? "")")
    }
    
    static func apiDebugging(url: String, method: String) {
        Logger.networkCategory.debug("\(method): API debugging for \(url)")
    }
    
    //MARK: - Coredata logging
    static func dbOperationSuccess(entityName: String, operationName: String) {
        Logger.dbCategory.info("DB \(operationName) success for entity name \(entityName)")
    }
    
    static func dbOperationFailure(entityName: String, operationName: String, message: String?) {
        Logger.dbCategory.error("DB \(operationName) failure for entity name \(entityName) with \(message ?? "")")
    }
    
    static func dbDebugging(entityName: String, operationName: String) {
        Logger.dbCategory.debug("DB \(operationName) debugging for entity name \(entityName)")
    }
    
    enum DBOperations: String {
        case insert
        case delete
        case fetch
        case update
    }
}
