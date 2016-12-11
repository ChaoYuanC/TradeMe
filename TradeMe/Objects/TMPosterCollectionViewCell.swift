//
//  TMPosterCollectionViewCell.swift
//  TradeMe
//
//  Created by Chao Yuan on 11/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit
import SDWebImage

class TMPosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet var posterImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupWith(posterUrl: String) {
        guard let url = URL(string: posterUrl) else {
            return
        }
        
        posterImageView?.sd_setImage(with: url, placeholderImage: UIImage(named: "thumbnail_defualt_icon"), options: .refreshCached)
    }
    
}
