//
//  TMListingObject.swift
//  TradeMe
//
//  Created by Chao Yuan on 9/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit

class TMListingObject: NSObject {
    let thumbnail: String?
    let listingId: Int
    let listingTitle: String
    
    init(dic: NSDictionary) {
        self.thumbnail = dic.optionalStringForKey("PictureHref")
        self.listingId = dic.intForKey("ListingId")
        self.listingTitle = dic.stringForKey("Title")
    }
}
