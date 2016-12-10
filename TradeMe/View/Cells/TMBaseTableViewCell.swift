//
//  TMBaseTableViewCell.swift
//  TradeMe
//
//  Created by Chao Yuan on 9/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    
    
    // Used to calculate height for a base cell
    @IBOutlet var heightView: UIView? {
        didSet {
            if let heightView = self.heightView { heightView.backgroundColor = UIColor.clear }
        }
    }
    
    var state: UIControlState {
        get {
            if !self.isUserInteractionEnabled {
                return UIControlState.disabled
            } else if self.isHighlighted {
                return UIControlState.highlighted
            } else if self.isSelected {
                return UIControlState.selected
            } else {
                return UIControlState()
            }
        }
    }
    
    
    func cellHeight() -> CGFloat {
        
        self.layoutIfNeeded()
        
        if let heightView = self.heightView {
            return heightView.bounds.size.height
        }
        
        return self.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
    
    
    
}

