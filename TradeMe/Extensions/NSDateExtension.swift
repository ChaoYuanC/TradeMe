//
//  NSDateExtension.swift
//  TradeMe
//
//  Created by Chao Yuan on 11/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import Foundation

extension NSDate {
    
    static func dateFromMicrosoftJsonString(jsonString: String) -> NSDate? {
        let prefix = "/Date("
        let suffix = ")/"
        
        // Check for correct format:
        guard jsonString.hasPrefix(prefix) && jsonString.hasSuffix(suffix) else { return nil }
        
        // Extract the number as a string:
        let from = jsonString.index(jsonString.startIndex, offsetBy: prefix.characters.count)
        let to = jsonString.index(jsonString.endIndex, offsetBy: -suffix.characters.count)
        
        // Convert milliseconds to double
        guard let milliSeconds = Double(jsonString[from ..< to]) else { return nil }
        
        // Create NSDate with this UNIX timestamp
        return NSDate(timeIntervalSince1970: milliSeconds/1000.0)
    }
    
    func fullDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Foundation.DateFormatter.dateFormat(fromTemplate: "d MMM yyyy", options: 0, locale: DateFormatter().locale)!
        return formatter.string(from: self as Date)
        
    }
}
