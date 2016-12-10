//
//  CartManager.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation

struct CartItem {
    var menuItem: MenuItem
    var quantity: Int
}

class CartManager {
    
    static let shared = CartManager()
    private init() {}
    
    fileprivate(set) var items = [CartItem]()
    
    
    func addItemToCart(item: CartItem) {
        items.append(item)
    }
    
    func deleteItemFromCart(item: CartItem) {
        
        var itemIndex: Int?
        for (index, cartItem) in items.enumerated() {
            
            if item.menuItem.id == cartItem.menuItem.id {
                itemIndex = index
                break
            }
        }
        
        if let index = itemIndex {
            items.remove(at: index)
        }
    }
    
}
