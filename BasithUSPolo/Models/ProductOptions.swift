//
//  ProductOptions.swift
//  BasithUSPolo
//
//  Created by Basith on 05/01/21.
//

import Foundation

class ProductOptions{
    init(name: String, product_option_value: [ProductOptionValue]) {
        self.name = name
        self.product_option_value = product_option_value
    }
    
    var name : String = ""
    var product_option_value : [ProductOptionValue] = []
}


class ProductOptionValue {
    internal init(product_option_value_id: String, name: String, color_code: String) {
        self.product_option_value_id = product_option_value_id
        self.name = name
        self.color_code = color_code
    }
    
    var product_option_value_id : String = ""
    var name : String = ""
    var color_code : String = "#fff"
}

class RelatedProducts {
    
    init(product_id: String, name: String, price: String, image: String) {
        self.product_id = product_id
        self.name = name
        self.price = price
        self.image = image
    }
    
    var product_id : String = ""
    var name : String = ""
    var price : String = ""
    var image : String = ""
    
}
