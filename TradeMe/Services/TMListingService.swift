//
//  TMListingService.swift
//  TradeMe
//
//  Created by Chao Yuan on 9/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit
import Alamofire

class TMListingService: NSObject {
    // TODO: Pages
    func getListingWith(categoryNumber: String?, completion: @escaping (_ response: [TMListingObject]?, _ success: Bool) -> Void) {
        
        var requestURL = "https://api.tmsandbox.co.nz/v1/Search/General.json"
        if let categoryNumber = categoryNumber {
            requestURL = requestURL+"?"+"category=\(categoryNumber)"
        }
        
        let headers: [String: String] = [
            "Authorization": "OAuth oauth_consumer_key=A1AC63F0332A131A78FAC304D007E7D1, oauth_token=F79AD745526E29976A294F12779463D1, oauth_signature_method=PLAINTEXT, oauth_signature=EC7F18B17A062962C6930A8AE88B16C7&ADB48D4AD130C6FC68BC99259C035943",
        ]
        Alamofire.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            switch response.result {
            case let .success(value):
                completion(self.listingWith(dic: value as? NSDictionary), true)
                break
            case .failure(_):
                completion(nil, false)
            }
        })
        
    }
    
    
    // MARK: - Parse
    
    
    fileprivate func listingWith(dic: NSDictionary?) -> [TMListingObject]? {
        guard let dic = dic else {
            return nil
        }
        
        let listingArray = dic.arrayForKey("List")
        
        var listingObjects = [TMListingObject]()
        for listingDic in listingArray {
            if let listingDic = listingDic as? NSDictionary {
                listingObjects.append(TMListingObject(dic: listingDic))
            }
        }
        
        return listingObjects
    }
}
