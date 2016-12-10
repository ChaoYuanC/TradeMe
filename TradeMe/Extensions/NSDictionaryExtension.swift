//
//  NSDictionaryExtension.swift
//  TradeMe
//
//  Created by Chao Yuan on 9/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import Foundation
import UIKit

extension NSDictionary {
    
    
    
    // MARK: Helpers
    
    func intForKey(_ key: String) -> Int {
        
        if let int = self[key] as? Int {
            return int
        } else if let string = self.optionalStringForKey(key), let int = Int(string) {
            return int
        } else {
            return Int(self.numberForKey(key).int32Value)
        }
    }
    
    func decimalForKey(_ key: String) -> NSDecimalNumber {
        
        if let number = self[key] as? NSNumber {
            return NSDecimalNumber(string: number.stringValue)
        } else if let stringValue = self[key] as? String {
            return NSDecimalNumber(string: stringValue)
        }
        return 0
    }
    
    func optionalNumberForKey(_ key: String) -> NSNumber? {
        if let number = self[key] as? NSNumber {
            return number
        }
        return nil
    }
    
    func numberForKey(_ key: String) -> NSNumber {
        return self.optionalNumberForKey(key) ?? self.decimalForKey(key)
    }
    
    func optionalStringForKey(_ key: String) -> String? {
        if let string = self[key] as? String {
            return string
        } else if let value = self[key] as? NSNumber {
            return value.stringValue
        }
        return nil
    }
    
    func stringForKey(_ key: String) -> String {
        return self.optionalStringForKey(key) ?? ""
    }
    
    func optionalBoolForKey(_ key: String) -> Bool? {
        if let stringValue = self.optionalStringForKey(key) {
            return NSString(string: stringValue).boolValue
        }
        return self[key] as? Bool
    }
    
    func boolForKey(_ key: String) -> Bool {
        if let value = self.optionalBoolForKey(key) {
            return value
        }
        return false
    }
    
    func stringArrayForKey(_ key: String) -> [String] {
        return self[key] as? [String] ?? [String]()
    }
    
    func optionalArrayForKey(_ key: String) -> NSArray? {
        return self[key] as? NSArray
    }
    
    func arrayForKey(_ key: String) -> NSArray {
        return self.optionalArrayForKey(key) ?? NSArray()
    }
    
    func optionalDictionaryForKey(_ key: String) -> NSDictionary? {
        return self[key] as? NSDictionary
    }
    
    func dictionaryForKey(_ key: String) -> NSDictionary {
        return self.optionalDictionaryForKey(key) ?? NSDictionary()
    }
    
    
}
