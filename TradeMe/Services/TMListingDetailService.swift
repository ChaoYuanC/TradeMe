//
//  TMListingDetailService.swift
//  TradeMe
//
//  Created by Chao Yuan on 9/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit
import Alamofire

class TMListingDetailService: NSObject {
    // TODO: Pages
    func getListingDetailWith(listingId: String, completion: @escaping (_ posterObject: TMPosterObject?, _ sections: [TMListingDetailSection]?, _ success: Bool) -> Void) {
        
        let requestURL = "https://api.tmsandbox.co.nz/v1/Listings/\(listingId).json"
        
        let headers: [String: String] = [
            "Authorization": "OAuth oauth_consumer_key=A1AC63F0332A131A78FAC304D007E7D1, oauth_token=F79AD745526E29976A294F12779463D1, oauth_signature_method=PLAINTEXT, oauth_signature=EC7F18B17A062962C6930A8AE88B16C7&ADB48D4AD130C6FC68BC99259C035943",
            ]
        Alamofire.request(requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            switch response.result {
            case let .success(value):
                if let dic = value as? NSDictionary {
                    let factory = TMListingDetailsFactory()
                    completion(factory.posterHeader(detailDictionary: dic), factory.listingDetail(detailDictionary: dic), true)
                } else {
                    completion(nil, nil, false)
                }
                break
            case .failure(_):
                completion(nil, nil, false)
            }
        })
    }
    


}
