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
    
    static let loggerCateogry = Logger(subsystem: subsystem, category: "apiResponse")
    
    static func apiResponseSuccess(url: String, method: String, message: String?) {
        Logger.loggerCateogry.info("\(method): API response success for \(url) with \(message ?? "")")
    }
    
    static func apiResponseFailure(url: String, method: String, message: String?) {
        Logger.loggerCateogry.error("\(method): API response failed for \(url) with \(message ?? "")")
    }
    
    static func apiDebugging(url: String, method: String) {
        Logger.loggerCateogry.debug("\(method): API debugging for \(url)")
    }
}
