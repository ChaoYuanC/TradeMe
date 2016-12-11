//
//  TMListingDetailsFactory.swift
//  TradeMe
//
//  Created by Chao Yuan on 11/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit

class TMListingDetailsFactory {
    fileprivate enum DetailType: String {
        case Car = "0001"
        case Property = "0002"
    }
    

    func posterHeader(detailDictionary: NSDictionary) -> TMPosterObject {
        return self.posterObject(detailDictionary)
    }
    
    func listingDetail(detailDictionary: NSDictionary) -> [TMListingDetailSection]? {
        guard let detailType =  self.detailType(detailDictionary) else {
            return nil
        }
        
        switch detailType {
        case .Car:
            return self.carDetails(detailDictionary)
        case .Property:
            break
        }
        
        return nil
    }
    
    // MARK: - Private
    
    fileprivate func detailType(_ detailDictionary: NSDictionary) -> DetailType? {
        let dividedCategory = detailDictionary.stringForKey("Category").characters.split{$0 == "-"}.map(String.init)

        guard dividedCategory.count > 0 else {
            return nil
        }
    
        let category = dividedCategory[0]
        if category == DetailType.Car.rawValue {
            return .Car
        } else if category == DetailType.Property.rawValue {
            return .Property
        }
        
        return nil
    }
    
    // MARK: - Car
    fileprivate func carDetails(_ detailDictionary: NSDictionary) ->  [TMListingDetailSection] {

        let detailSectoin = TMListingDetailSection(sectionTitle: "Detail", cells: self.itmeAttributes(detailDictionary))
        
        return [detailSectoin]
    }
    
    
    // MARK: - Cell
    
    
    fileprivate func posterObject(_ detailDictionary: NSDictionary) -> TMPosterObject {
        var photos = [String]()
        for photoDic in detailDictionary.arrayForKey("Photos") {
            if let photoDic = photoDic as? NSDictionary {
                let url = photoDic.dictionaryForKey("Value").stringForKey("Gallery")
                photos.append(url)
            }
        }
        
        let title = detailDictionary.stringForKey("Title")

        var listedDateString = ""
        if let listedDate = NSDate.dateFromMicrosoftJsonString(jsonString: detailDictionary.stringForKey("StartDate")) {
            if NSCalendar.current.isDateInToday(listedDate as Date){
                listedDateString = "Today"
            } else {
                listedDateString = listedDate.fullDateString()
            }
        }

        let priceString = detailDictionary.stringForKey("PriceDisplay")
        return TMPosterObject(posters: photos, title: title, listedDate: listedDateString, priceString: priceString)
    }
    
    fileprivate func itmeAttributes(_ detailDictionary: NSDictionary) -> [DetailCell] {
        let attributesArray = detailDictionary.arrayForKey("Attributes")
        
        var attributeCells = [DetailCell]()
        for attribute in attributesArray {
            if let attributeDic = attribute as? NSDictionary {
                let attributeName = attributeDic.stringForKey("DisplayName")
                let attributeValue = attributeDic.stringForKey("Value")
                let cell = DetailCell.DescriptionCell(TMAttributeObject(title: attributeName, value: attributeValue))
                attributeCells.append(cell)
            }
        }
        return attributeCells
    }
    
}
