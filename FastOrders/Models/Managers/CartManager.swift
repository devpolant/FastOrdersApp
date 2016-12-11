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
    var currentMerchant: Merchant?
    
    var totalPrice: Double {
        var price = 0.0
        for item in items {
            price += item.menuItem.price * Double(item.quantity)
        }
        return price
    }
    
    func addItemToCart(item: CartItem) {
        
        if let index = indexOf(item: item) {
            items[index].quantity += item.quantity
        } else {
            items.append(item)
        }
    }
    
    func deleteItemFromCart(item: CartItem) {
        
        if let index = indexOf(item: item) {
            items.remove(at: index)
        }
    }
    
    func clear() {
        items.removeAll()
        currentMerchant = nil
    }
    
    private func indexOf(item: CartItem) -> Int? {
        
        var itemIndex: Int?
        for (index, cartItem) in items.enumerated() {
            
            if item.menuItem.id == cartItem.menuItem.id {
                itemIndex = index
                break
            }
        }
        return itemIndex
    }
    
}
