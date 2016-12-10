//
//  TMListingDetailViewController.swift
//  TradeMe
//
//  Created by Chao Yuan on 9/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit

class TMListingDetailViewController: UIViewController {

    var listingId: Int?
    
    fileprivate let listingDetailService = TMListingDetailService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let listingId = self.listingId {
            self.listingDetailService.getListingDetailWith(listingId: String(listingId), completion: { (section, success) in
                
            })

        }
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

}
