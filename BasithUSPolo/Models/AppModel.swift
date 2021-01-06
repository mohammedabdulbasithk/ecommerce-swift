//
//  AppModel.swift
//  BasithUSPolo
//
//  Created by Basith on 04/01/21.
//

import Foundation
import Alamofire
import UIKit

class AppModel {
    
    static let sharedInstance = AppModel()
    
    
    func getProducts(completion: @escaping ([Products])->Void){
        let parameters = [
            "user_id": "69",
            "device_type":"iOS",
            "customer_id":"69",
            "token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjdXN0b21lcl9pZCI6IjY5IiwiaWF0IjoxNjA2ODgzNjE3fQ.QK13epjPKnc-twJCwObDVNenfPsmw2HR1f9lJUG3CEo",
            "language_id":"1",
            "country_id":"225",
            "area_id":"1716",
            "main_category_id":"1",
            "category_id_l2":"6",
            "category_id_l1":"2"
        ]
        
        var list : [Products] = []
        
        AF.request("https://beta.gastro-admin.xyz/mobileapi/retail/get_top_sellers_products", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:AFDataResponse<Any>) -> Void in
            switch(response.result) {
            case .success(_):
                if let data2 = response.value { 
                    let productResult = data2 as! NSDictionary
                    if let data = productResult["products"] as? NSArray {
                        if(data.count > 0){
                            for index in 0..<data.count {
                                let field = data[index] as! NSDictionary
                                
                                guard let product_id =  field["product_id"] as? String, let name =  field["name"] as? String , let image =  field["image"] as? String , let price =  field["price"] as? String else {
                                    continue
                                }
                                let rating =  field["rating"] as? String ?? "4.0"
                                let a = Products(product_id: product_id, name: name, image: image, price: price, rating: rating)
                                list.append(a)
                            }
                            completion(list)
                        }
                    }
                    
                    
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    
    
}
