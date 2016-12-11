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
    
    private lazy var headerView: TMPosterHeaderView = {
        return Bundle.main.loadNibNamed("TMPosterHeaderView", owner: nil, options: nil)![0] as! TMPosterHeaderView
    }()
    
    private let attributeCellIdentifier = "TMAttributeTableViewCell"
    private lazy var attributeCell: TMAttributeTableViewCell = {
        return Bundle.main.loadNibNamed(self.attributeCellIdentifier, owner: nil, options: nil)![0] as! TMAttributeTableViewCell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.navigationItem.hidesBackButton = true
        }
        
        self.registerCells()

        self.reloadListingDetailData()
    }

    func reloadListingDetailData() {
        guard let listingId = self.listingId else {
            return
        }
        
        self.loadingView.isHidden = false
        self.activityIndicatorView.startAnimating()
        self.listingDetailService.getListingDetailWith(listingId: String(listingId), completion: { (headerData, sections, success) in
            self.loadingView.isHidden = true
            self.activityIndicatorView.stopAnimating()
            if success {
                self.title = headerData?.title
                
                if let headerData = headerData {
                    self.tableView.tableHeaderView = self.headerViewWithObject(headerData)
                } else {
                    self.tableView.tableHeaderView = nil
                }
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
        case let .DescriptionCell(TMAttributeObject):
            self.setupAttributeCell(self.attributeCell, TMAttributeObject)
            return self.attributeCell.cellHeight()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = self.cellDataWith(indexPath) else {
            return UITableViewCell()
        }
        
        switch cellData {
        case let .DescriptionCell(TMAttributeObject):
            let cell = tableView.dequeueReusableCell(withIdentifier: self.attributeCellIdentifier) as! TMAttributeTableViewCell
            self.setupAttributeCell(cell, TMAttributeObject)
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitle(section)
    }
    
    
    // MARK: - Private
    
    
    fileprivate func headerViewWithObject(_ object: TMPosterObject) -> TMPosterHeaderView {
        self.headerView.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: 0)
        self.headerView.setupWith(object: object)
        self.headerView.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.headerView.headerHeight())
        return self.headerView
    }
    
    fileprivate func cellDataWith(_ indexPath: IndexPath) -> DetailCell? {
        return self.detailsSections?[indexPath.section].cells?[indexPath.row]
    }
    
    fileprivate func sectionTitle(_ section: Int) -> String? {
        return self.detailsSections?[section].sectionTitle
    }
    
    fileprivate func registerCells() {
        self.tableView.registerNibForCellReuseIdentifier(self.attributeCellIdentifier)
    }
    
}

extension TMListingDetailViewController {
    
    func setupAttributeCell(_ cell: TMAttributeTableViewCell, _ object: TMAttributeObject) {
        cell.setupWith(object: object)
    }
}

