//
//  ItemDetailsInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation

class ItemDetailsInteractor : Interactor <ItemDetailsViewController> {
    
    
    //MARK: - Actions
    
    func actionAddItemToCart(menuItem: MenuItem, quantity: Int) {
        
        let cartItem = CartItem(menuItem: menuItem, quantity: quantity)
        
        CartManager.shared.addItemToCart(item: cartItem)
        
        viewController?.router.dismiss(animated: true)
    }
    
}
