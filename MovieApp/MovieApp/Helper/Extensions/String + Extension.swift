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

//MARK: - Boyer Morre algorithm

extension String {
  fileprivate var skipTable: [Character: Int] {
    var skipTable: [Character: Int] = [:]
    for (i, c) in enumerated() {
      skipTable[c] = count - i - 1
    }
    return skipTable
  }
  
  fileprivate func match(from currentIndex: Index, with pattern: String) -> Index? {
    if currentIndex < startIndex { return nil }
    if currentIndex >= endIndex { return nil }
    
    if self[currentIndex] != pattern.last { return nil }
    
    if pattern.count == 1 && self[currentIndex] == pattern.last { return currentIndex }
    return match(from: index(before: currentIndex), with: "\(pattern.dropLast())")
  }
  
  func index(of pattern: String) -> Index? {
    let patternLength = pattern.count
    guard patternLength > 0, patternLength <= count else { return nil }
    let skipTable = pattern.skipTable
    let lastChar = pattern.last!
    
    var i = index(startIndex, offsetBy: patternLength - 1)
    
    while i < endIndex {
      let c = self[i]
      
      if c == lastChar {
        if let k = match(from: i, with: pattern) { return k }
        i = index(after: i)
      } else {
        i = index(i, offsetBy: skipTable[c] ?? patternLength, limitedBy: endIndex) ?? endIndex
      }
    }
    return nil
  }
}

extension String {
    func searchString(patternValue: String) -> Bool {
        //Check pattern match using Boyer Morre String search algo
        let sourceArray = self.split(separator: " ")
        let patterArray = patternValue.split(separator: " ")
        var outputValue: Bool = false
        
        outerLoop: for pattern in patterArray {
              for source in sourceArray {
                let pv = String(pattern).trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                let v = String(source).trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                let hashValue = v.index(of: pv)?.utf16Offset(in: v)
                //For match with index as 0 return the source string
                if hashValue == 0 {
                    outputValue = true
                    break outerLoop
                }
            }
        }
        return outputValue
    }
}
