//
//  TMListingDetailPosterTableViewCell.swift
//  TradeMe
//
//  Created by Chao Yuan on 9/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit

class TMListingDetailPosterTableViewCell: BaseTableViewCell {

    
    @IBOutlet var posterImageView: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var endDateLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
