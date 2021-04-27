//
//  Logging.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 27/04/21.
//

import os.log
import Foundation

class LoggerRepository {
    static let shared = LoggerRepository()
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    let networkCategory = Logger(subsystem: subsystem, category: "apiResponse")
    let dbCategory = Logger(subsystem: subsystem, category: "dbOperations")
    
    //MARK: - Network leyer logging
    func apiResponseSuccess(url: String, method: String, message: String?) {
        networkCategory.info("\(method): API response success for \(url) with \(message ?? "")")
    }
    
    func apiResponseFailure(url: String, method: String, message: String?) {
        networkCategory.error("\(method): API response failed for \(url) with \(message ?? "")")
    }
    
    func apiDebugging(url: String, method: String) {
        networkCategory.debug("\(method): API debugging for \(url)")
    }
    
    //MARK: - Coredata logging
    func dbOperationSuccess(entityName: String, operationName: String) {
        dbCategory.info("DB \(operationName) success for entity name \(entityName)")
    }
    
    func dbOperationFailure(entityName: String, operationName: String, message: String?) {
        dbCategory.error("DB \(operationName) failure for entity name \(entityName) with \(message ?? "")")
    }
    
    func dbDebugging(entityName: String, operationName: String) {
        dbCategory.debug("DB \(operationName) debugging for entity name \(entityName)")
    }
    
    enum DBOperations: String {
        case insert
        case delete
        case fetch
        case update
        case dbIntialization
        case dbContextSave
    }
}
