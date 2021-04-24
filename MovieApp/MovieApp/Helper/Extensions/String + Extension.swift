//
//  String + Extension.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 24/04/21.
//

import Foundation

extension String {
    
    static func convertDateToStringUsingTimeStamp(_ timeStamp: String) -> String {
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = formatterDate.date(from: timeStamp)
        let myString = formatterDate.string(from: date ?? Date())
        let yourDate = formatterDate.date(from: myString)
        formatterDate.dateFormat = "EEEE, d MMMM"
        let myStringafd = formatterDate.string(from: yourDate!)
        return myStringafd
        
    }
}
