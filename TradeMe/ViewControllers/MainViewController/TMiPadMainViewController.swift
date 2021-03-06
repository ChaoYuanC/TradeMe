//
//  TMMainViewController.swift
//  TradeMe
//
//  Created by Chao Yuan on 8/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit
import SideMenu
class TMiPadMainViewController: UIViewController, TMCategoryViewControllerDelegate, TMListingViewControllerDelegate {

    var categoryNavigationController: UINavigationController!
    var listingNavigationController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryNavigationController = self.childViewControllers[0] as! UINavigationController
        listingNavigationController = self.childViewControllers[1] as! UINavigationController
        
        if let categoryController = categoryNavigationController.viewControllers[0] as? TMCategoryViewController {
            categoryController.delegate = self
        }
        
        if let listingController = listingNavigationController.viewControllers[0] as? TMListingViewController {
            listingController.delegate = self
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
    
    fileprivate func displaySubCategoryItems(categoryNumber: String?) {
        TMCategoryService.categoryService.getCategoryWith(categoryNumber: categoryNumber) { (category, success) in
            if category?.count ?? 0 > 0 {
                let nextCategoryVC = UIStoryboard(name: "Category", bundle: nil).instantiateViewController(withIdentifier: "TMCategoryViewController") as! TMCategoryViewController
                nextCategoryVC.categoryNumber = categoryNumber
                nextCategoryVC.delegate = self
                self.categoryNavigationController.pushViewController(nextCategoryVC, animated: true)
            } else {
                if let categoryNum = categoryNumber {
                    self.displayListingItems(categoryNumber: categoryNum)
                }
            }
            
        }
    }
    
    fileprivate func displayListingItems(categoryNumber: String?) {
        TMCategoryService.categoryService.getCategoryWith(categoryNumber: categoryNumber) { (category, success) in
            if !(self.listingNavigationController.topViewController is TMListingViewController) {
                self.listingNavigationController.popToRootViewController(animated: true)
            }
            
            self.showListingItems(category: categoryNumber, keyword: nil)
        }
    }
    
    fileprivate func showListingItems(category: String?, keyword: String?) {
        if let listingController = self.listingNavigationController.viewControllers[0] as? TMListingViewController {
            listingController.categoryNumber = category
            listingController.keyword = keyword
            listingController.reloadListingData()
        }
    }
    
    // MARK: -  category / listing navigation delegates
    
    func categoryViewControllerDidCategoryChange(controller: TMCategoryViewController, category: String?) {
        displayListingItems(categoryNumber: category)
    }
    
    func categoryViewControllerDidCategorySelect(controller: TMCategoryViewController, category: String) {
        displaySubCategoryItems(categoryNumber: category)
    }
    
    func categoryViewControllerDidSearch(controller: TMCategoryViewController, category: String?, keyword: String) {
        self.showListingItems(category: category, keyword: keyword)
    }

    func listingViewControllerDidSelect(controller: TMListingViewController, listingId: Int?) {
        if let detailViewController = self.listingNavigationController.topViewController as? TMListingDetailViewController {
            detailViewController.listingId = listingId
            detailViewController.reloadListingDetailData()
        } else {
            let listingVC = UIStoryboard(name: "Listing", bundle: nil).instantiateViewController(withIdentifier: "TMListingViewController")
            if let listingVC = listingVC as? TMListingViewController {
                listingVC.categoryNumber = controller.categoryNumber
                listingVC.delegate = self
            }
            self.categoryNavigationController.pushViewController(listingVC, animated: true)
            
            controller.performSegue(withIdentifier: "TMListingDetailViewController", sender: listingId)
        }
        


    }
}
