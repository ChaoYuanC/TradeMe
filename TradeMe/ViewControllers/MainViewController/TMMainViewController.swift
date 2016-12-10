//
//  TMMainViewController.swift
//  TradeMe
//
//  Created by Chao Yuan on 8/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit
import SideMenu
class TMMainViewController: UINavigationController, TMCategoryViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let categoryController = self.viewControllers[0] as? TMCategoryViewController {
            categoryController.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    
    
    
    // MARK: - Private
    
    fileprivate func setupSideMenu() {
        SideMenuManager.menuRightNavigationController = UIStoryboard(name: "Category", bundle: nil).instantiateInitialViewController() as? UISideMenuNavigationController
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuPresentMode = .viewSlideInOut
        let screenBounds = UIApplication.shared.keyWindow?.bounds ?? UIWindow().bounds
        SideMenuManager.menuWidth = screenBounds.size.width - 40
    }
    
    fileprivate func displayCategoryOrListingItems(categoryNumber: String) {
        TMCategoryService.categoryService.getCategoryWith(categoryNumber: categoryNumber) { (category, success) in
            if category?.count ?? 0 > 0 {
                let nextCategoryVC = UIStoryboard(name: "Category", bundle: nil).instantiateViewController(withIdentifier: "TMCategoryViewController") as! TMCategoryViewController
                nextCategoryVC.categoryNumber = categoryNumber
                nextCategoryVC.delegate = self
                self.pushViewController(nextCategoryVC, animated: true)
            } else {
                self.showListingItems(category: categoryNumber, keyword: nil)
            }
        }
    }
    
    fileprivate func showListingItems(category: String?, keyword: String?) {
        let listingVC = UIStoryboard(name: "Listing", bundle: nil).instantiateViewController(withIdentifier: "TMListingViewController")
        if let listingVC = listingVC as? TMListingViewController {
            listingVC.categoryNumber = category
            listingVC.keyword = keyword
        }
        self.pushViewController(listingVC, animated: true)
    }
    
    
    // MARK: -  category / listing navigation delegates
    
    
    func categoryViewControllerDidCategoryChange(controller: TMCategoryViewController, category: String?) {

    }
    
    func categoryViewControllerDidCategorySelect(controller: TMCategoryViewController, category: String) {
        displayCategoryOrListingItems(categoryNumber: category)
    }
    
    func categoryViewControllerDidSearch(controller: TMCategoryViewController, category: String?, keyword: String) {
        self.showListingItems(category: category, keyword: keyword)
    }
}
