//
//  OrderItem.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation

final class OrderItem {
    
    var id: String
    var orderId: String
    var menuItem: MenuItem
    var quantity: Int
    
    init(id: String, orderId: String, menuItem: MenuItem, quantity: Int) {
        self.id = id
        self.orderId = orderId
        self.menuItem = menuItem
        self.quantity = quantity
    }
    
}


//MARK: - JsonInitializable
extension OrderItem: JsonInitializable {
    
    convenience init(from json: [String: Any]) {
        self.init(id: json["_id"] as! String,
                  orderId: json["order_id"] as! String,
                  menuItem: MenuItem(from: json["menu_item"] as! [String: Any]),
                  quantity: json["quantity"] as! Int)
    }
}
