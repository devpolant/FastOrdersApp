//
//  MenuCategory.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 06.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation

final class MenuCategory {
    
    var id: String
    var name: String
    var description: String
    var merchantId: String
    var photoUrl: String?
    
    init(id: String, name: String, description: String, merchantId: String, photoUrl: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.merchantId = merchantId
        self.photoUrl = photoUrl
    }
    
}


//MARK: - JsonInitializable
extension MenuCategory: JsonInitializable {
    
    convenience init(from json: [String: Any]) {
        self.init(id: json["_id"] as! String,
                  name: json["name"] as! String,
                  description: json["description"] as! String,
                  merchantId: json["merchant_id"] as! String,
                  photoUrl: json["photo_url"] as? String)
    }
}
