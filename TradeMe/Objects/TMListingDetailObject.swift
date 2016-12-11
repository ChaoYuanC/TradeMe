//
//  TMListingDetailObject.swift
//  TradeMe
//
//  Created by Chao Yuan on 9/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit


struct TMAttributeObject {
    let title: String
    let value: String
}

struct TMPosterObject {
    let posters: [String]?
    let title: String
    let listedDate: String?
    let priceString: String
}

enum DetailCell {
    case DescriptionCell(TMAttributeObject)
}

class TMListingDetailSection {
    let sectionTitle: String?
    let cells: [DetailCell]?
    init(sectionTitle: String, cells: [DetailCell]?) {
        self.sectionTitle = sectionTitle
        self.cells = cells
    }
    
}
