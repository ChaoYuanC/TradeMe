//
//  TMCategoryViewController.swift
//  TradeMe
//
//  Created by Chao Yuan on 9/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit
import Foundation
import SideMenu

protocol TMCategoryViewControllerDelegate : class {
    func categoryViewControllerDidCategorySelect(controller: TMCategoryViewController, category: String)
    func categoryViewControllerDidCategoryChange(controller: TMCategoryViewController, category: String?)
    func categoryViewControllerDidSearch(controller: TMCategoryViewController, category: String?, keyword: String)
}

class TMCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    weak var delegate: TMCategoryViewControllerDelegate?
    
    var categoryNumber: String? = nil
    fileprivate var categories: [TMCategoryObject]? = nil
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    private let categoryCellIdentifier = "TMCategoryTableViewCell"
    private lazy var categoryCell: TMCategoryTableViewCell = {
        return Bundle.main.loadNibNamed(self.categoryCellIdentifier, owner: nil, options: nil)![0] as! TMCategoryTableViewCell
    }()
    
    fileprivate let categoryService = TMCategoryService.categoryService
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNibForCellReuseIdentifier(self.categoryCellIdentifier)
        
        self.activityIndicatorView.startAnimating()
        self.loadingView.isHidden = false
        self.categoryService.getCategoryWith(categoryNumber: categoryNumber) { (category, success) in
            self.activityIndicatorView.stopAnimating()
            self.loadingView.isHidden = true
            self.categories = category
            self.tableView.reloadData()
            if !success {
                self.showErrorAlert()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.categoryViewControllerDidCategoryChange(controller: self, category: categoryNumber)
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
        return self.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = self.categoryCell
        self.setupCell(cell: cell, indexPath: indexPath)
        return cell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.categoryCellIdentifier) as! TMCategoryTableViewCell
        self.setupCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.resignFirstResponder()

        if let number = self.categories?[indexPath.row].number {
            self.delegate?.categoryViewControllerDidCategorySelect(controller: self, category: number)
        }
    }
    
    // MARK: - Search bar delegates
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            self.delegate?.categoryViewControllerDidSearch(controller: self, category: self.categoryNumber, keyword: searchText)
        }

    }
    
    
    fileprivate func setupCell(cell: TMCategoryTableViewCell, indexPath: IndexPath) {
        let categoryName = self.categories?[indexPath.row].name
        cell.titleLabel?.text = categoryName
    }
    
    
    // MARK: - Alert
    
    
    fileprivate func showErrorAlert() {
        let alert = UIAlertController(title: "Sorry!", message: "Can not get categories, please try later", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
}
