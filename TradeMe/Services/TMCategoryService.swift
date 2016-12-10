//
//  TMCategoryService.swift
//  TradeMe
//
//  Created by Chao Yuan on 8/12/16.
//  Copyright © 2016 TradeMe. All rights reserved.
//

import UIKit
import Alamofire

class TMCategoryService: NSObject {
     class var categoryService: TMCategoryService {
        struct Singleton {
            static let instance = TMCategoryService()
        }
        
        return Singleton.instance
    }
    
    fileprivate var categoryResponse: NSDictionary? = nil
    
    func getCategoryWith(categoryNumber: String?, completion: @escaping (_ response: [TMCategoryObject]?, _ success: Bool) -> Void) {
        
        if categoryResponse == nil {
            Alamofire.request("https://api.tmsandbox.co.nz/v1/Categories/0.json", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                switch response.result {
                case let .success(value):
                    if let dic = value as? NSDictionary {
                        self.categoryResponse = dic
                        let categoryObject = self.paresCategory(self.categoryResponse, categoryNumber)
                        completion(categoryObject, true)
                    }
                case .failure(_):
                    completion(nil, false)
                }
            })

        } else {
            let categoryObject = self.paresCategory(self.categoryResponse, categoryNumber)
            completion(categoryObject, true)
        }
        
    }

    
    // MARK: - Private
    
    
    fileprivate func paresCategory(_ category: NSDictionary?, _ categoryNumber: String?) -> [TMCategoryObject]? {
        guard let categoryDic = category else {
            return nil
        }
        

        if categoryNumber == categoryDic.stringForKey("Number") || categoryNumber == nil {
            let categoryArray = categoryDic.arrayForKey("Subcategories")
            //create CategoryObject array
            var categoryObject = [TMCategoryObject]()
            for dic in categoryArray {
                if let dic = dic as? NSDictionary {
                    let name = dic.stringForKey("Name")
                    let number = dic.stringForKey("Number")
                    categoryObject.append(TMCategoryObject(name: name, number: number))
                }
            }
            return categoryObject
        } else {
            let categoryArray = categoryDic.arrayForKey("Subcategories")

            for dic in categoryArray {
                let array = self.paresCategory(dic as? NSDictionary, categoryNumber)
                if array?.count ?? 0 > 0 {
                    return array
                }
            }
        }
        
        return nil
    }
}
