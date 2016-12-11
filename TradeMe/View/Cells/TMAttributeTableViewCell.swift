//
//  TMAttributeTableViewCell.swift
//  TradeMe
//
//  Created by Chao Yuan on 11/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit

class TMAttributeTableViewCell: BaseTableViewCell {

    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var valueLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel?.textColor = UIColor.lightGray
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWith(object: TMAttributeObject) {
        self.titleLabel?.text = object.title
        self.valueLabel?.text = object.value
    }
}
