//
//  TMListingViewController.swift
//  TradeMe
//
//  Created by Chao Yuan on 8/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit
import SideMenu
import MJRefresh

protocol TMListingViewControllerDelegate : class {
    func listingViewControllerDidSelect(controller: TMListingViewController, listingId: Int?)
}

class TMListingViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    var categoryNumber: String?
    var keyword: String?
    
    weak var delegate: TMListingViewControllerDelegate?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    fileprivate let listingService = TMListingService()
    fileprivate var listingObjects = [TMListingObject]()
    fileprivate var currentPage = 1
    
    private let listingCellIdentifier = "TMListingTableViewCell"
    private lazy var listingCell: TMListingTableViewCell = {
        return Bundle.main.loadNibNamed(self.listingCellIdentifier, owner: nil, options: nil)![0] as! TMListingTableViewCell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNibForCellReuseIdentifier(self.listingCellIdentifier)
        self.loadingView.isHidden = false
        self.activityIndicatorView.startAnimating()

        reloadListingData()
    }

    func reloadListingData() {
        self.currentPage = 1
        self.listingObjects = [TMListingObject]()
        self.loadListingData(self.currentPage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listingObjects.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.listingCell.frame = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 0)
        let cell = self.listingCell
        self.setupCell(cell: cell, indexPath: indexPath)
        return cell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.listingCellIdentifier) as! TMListingTableViewCell
        self.setupCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listingObject = self.listingObjects[indexPath.row]
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.delegate?.listingViewControllerDidSelect(controller: self, listingId: listingObject.listingId)
        } else {
            self.performSegue(withIdentifier: "TMListingDetailViewController", sender: listingObject.listingId)
        }

    }
    
    fileprivate func setupCell(cell: TMListingTableViewCell, indexPath: IndexPath) {
        cell.setupWith(listingObject: self.listingObjects[indexPath.row] )
    }
    
    @objc fileprivate func loadNext() {
        self.currentPage += 1
        self.loadListingData(self.currentPage)
    }
    
    fileprivate func loadListingData(_ page: Int) {
        self.listingService.getListingWith(categoryNumber: categoryNumber, searchString: keyword, page: page) { (totalCount, listingObjects, success) in
            self.loadingView.isHidden = true
            self.activityIndicatorView.stopAnimating()
            if success {
                if let listingObjects = listingObjects {
                    self.listingObjects += listingObjects
                    self.setFooterLoaderView(totalCount, self.listingObjects.count)
                    self.tableView.reloadData()
                }
            } else {
                //show alert
            }
        }
    }
    
    fileprivate func hasMoreData(_ totalCount: Int, _ objectsCount: Int) -> Bool {
        return totalCount > objectsCount
    }
    
    fileprivate func setFooterLoaderView(_ totalCount: Int, _ objectsCount: Int) {
        let hasMoreData = totalCount > objectsCount
        if hasMoreData {
            self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(TMListingViewController.loadNext))
        } else {
            self.tableView.mj_footer = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let listingId = sender as? Int {            
            let destinationViewController = segue.destination
            
            if let controller = destinationViewController as? TMListingDetailViewController {
                controller.listingId = listingId
            }
        }
    }
}
