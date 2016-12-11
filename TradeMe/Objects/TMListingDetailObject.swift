//
//  TMListingDetailObject.swift
//  TradeMe
//
//  Created by Chao Yuan on 9/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit


class TMDescriptionObject {
    let title: String
    let detail: String
    
    init(title: String, detail:String) {
        self.title = title
        self.detail = detail
    }
}

struct TMPosterObject {
    let posters: [String]?
    let title: String
    let listedDate: String?
    let priceString: String
}

enum DetailCell {
    case PosterCell(TMPosterObject)
    case DescriptionCell(TMDescriptionObject)
}

class TMListingDetailSection {
    let sectionTitle: String
    let cells: [DetailCell]?
    init(sectionTitle: String, cells: [DetailCell]?) {
        self.sectionTitle = sectionTitle
        self.cells = cells
    }
    
}
