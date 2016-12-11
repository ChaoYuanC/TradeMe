//
//  TMListingDetailViewController.swift
//  TradeMe
//
//  Created by Chao Yuan on 9/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit

class TMListingDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var listingId: Int?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    fileprivate var detailsSections: [TMListingDetailSection]?
    fileprivate let listingDetailService = TMListingDetailService()
    
    private let posterCellIdentifier = "TMPosterTableViewCell"
    private lazy var posterCell: TMPosterTableViewCell = {
        return Bundle.main.loadNibNamed(self.posterCellIdentifier, owner: nil, options: nil)![0] as! TMPosterTableViewCell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCells()
        
        self.reloadListingDetailData()
    }

    func reloadListingDetailData() {
        guard let listingId = self.listingId else {
            return
        }
        
        self.loadingView.isHidden = false
        self.activityIndicatorView.startAnimating()
        self.listingDetailService.getListingDetailWith(listingId: String(listingId), completion: { (sections, success) in
            self.loadingView.isHidden = true
            self.activityIndicatorView.stopAnimating()
            if success {
                self.detailsSections = sections
                self.tableView.reloadData()
            } else {
                //show alert
            }
        })

    }
    

    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.detailsSections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailsSections?[section].cells?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellData = self.cellDataWith(indexPath) else {
            return 0
        }
        
        switch cellData {
        case let .PosterCell(posterObject):
            self.setupPosterCell(self.posterCell, posterObject)
            return self.posterCell.cellHeight()
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = self.cellDataWith(indexPath) else {
            return UITableViewCell()
        }
        
        switch cellData {
        case let .PosterCell(posterObject):
            let cell = tableView.dequeueReusableCell(withIdentifier: self.posterCellIdentifier) as! TMPosterTableViewCell
            self.setupPosterCell(cell, posterObject)
            return cell
        default: return UITableViewCell()
        }

    }
    
    
    // MARK: - Private
    
    
    fileprivate func cellDataWith(_ indexPath: IndexPath) -> DetailCell? {
        return self.detailsSections?[indexPath.section].cells?[indexPath.row]
    }
    
    fileprivate func registerCells() {
        self.tableView.registerNibForCellReuseIdentifier(self.posterCellIdentifier)
    }
}

extension TMListingDetailViewController {
    func setupPosterCell(_ cell: TMPosterTableViewCell, _ object: TMPosterObject) {
        cell.setupWith(object: object)
    }
}

