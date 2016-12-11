//
//  UITableViewExtension.swift
//  TradeMe
//
//  Created by Chao Yuan on 9/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerNibForCellReuseIdentifier(_ identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func registerNibForHeaderFooterViewReuseIdentifier(_ identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func scrollToLastRow(_ animated: Bool) {
        
        if self.numberOfSections > 0 {
            
            var section = self.numberOfSections-1
            
            while section >= 0 {
                let numberOfRows = self.numberOfRows(inSection: section)
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: section)
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                    return
                }
                section -= 1
            }
        }
    }
}

extension UICollectionView {
    func registerNibForCellReuseIdentifier(_ identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
}

