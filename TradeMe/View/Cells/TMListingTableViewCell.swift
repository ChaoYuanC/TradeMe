//
//  TMListingTableViewCell.swift
//  TradeMe
//
//  Created by Chao Yuan on 9/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit
import SDWebImage
import Foundation

class TMListingTableViewCell: BaseTableViewCell {

    @IBOutlet var thumbnailImageView: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var listIdLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupWith(listingObject: TMListingObject) {
        self.thumbnailImageView?.sd_setImage(with: URL(string: listingObject.thumbnail ?? ""), placeholderImage: UIImage(
            named: "thumbnail_defualt_icon"), options: .refreshCached)
        self.titleLabel?.text = listingObject.listingTitle
        self.listIdLabel?.text = "Listing Id: \(listingObject.listingId)"
    }
}
