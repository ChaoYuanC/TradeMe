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

class TMPosterObject {
    let poster: String
    let title: String
    init(poster: String, title:String) {
        self.poster = poster
        self.title = title
    }
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
