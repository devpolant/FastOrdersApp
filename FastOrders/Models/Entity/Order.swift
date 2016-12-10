//
//  Order.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation

final class Order {
    
    var id: String
    var merchant: Merchant
    var createdDate: Date
    var availabilityDate: Date
    var totalPrice: Double
    var state: State
    
    var orderItems: [OrderItem]
    
    enum State: String {
        case unconfirmed = "unconfirmed"
        case approved = "approved"
        case declined = "declined"
        case completed = "completed"
    }
    
    init(id: String, merchant: Merchant, createdDate: Double, availabilityDate: Double, totalPrice: Double,
         state: State, orderItems: [OrderItem]) {
        self.id = id
        self.merchant = merchant
        self.createdDate = Date(timeIntervalSince1970: createdDate)
        self.availabilityDate = Date(timeIntervalSince1970: availabilityDate)
        self.totalPrice = totalPrice
        self.state = state
        self.orderItems = orderItems
    }
    
}


//MARK: - JsonInitializable
extension Order: JsonInitializable {
    
    convenience init(from json: [String: Any]) {
        
        let items = json["order_items"] as! Array<[String: Any]>
        var orderItems = [OrderItem]()
        
        for itemJson in items {
            orderItems.append(OrderItem(from: itemJson))
        }
        
        self.init(id: json["_id"] as! String,
                  merchant: Merchant(from: json["merchant"] as! [String: Any]),
                  createdDate: json["created_date"] as! Double,
                  availabilityDate: json["availability_date"] as! Double,
                  totalPrice: json["total_price"] as! Double,
                  state: State(rawValue: json["state"] as! String)!,
                  orderItems: orderItems)
    }
}
