//
//  MenuItem.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 07.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation

final class MenuItem {
    
    var id: String
    var name: String
    var description: String
    var categoryId: String
    var photoUrl: String?
    var price: Double
    
    init(id: String, name: String, description: String, categoryId: String, photoUrl: String? = nil, price: Double) {
        self.id = id
        self.name = name
        self.description = description
        self.categoryId = categoryId
        self.photoUrl = photoUrl
        self.price = price
    }
    
}


//MARK: - JsonInitializable
extension MenuItem: JsonInitializable {
    
    convenience init(from json: [String: Any]) {
        self.init(id: json["_id"] as! String,
                  name: json["name"] as! String,
                  description: json["description"] as! String,
                  categoryId: json["menu_category_id"] as! String,
                  photoUrl: json["photo_url"] as? String,
                  price: json["price"] as! Double)
    }
}
