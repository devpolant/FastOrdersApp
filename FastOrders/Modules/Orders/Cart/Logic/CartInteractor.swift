//
//  CartInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 11.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit
import PKHUD

class CartInteractor : Interactor<CartViewController> {

    
    //MARK: - Actions
    
    func actionSaveOrder(with items: [CartItem]?, orderDate: Date?) {
        
        let (isValid, message) = validate(items: items, orderDate: orderDate)
        
        guard isValid else {
            viewController?.showAlert(title: "Message", message: message!)
            return
        }
        
        guard let merchant = CartManager.shared.currentMerchant else { return }
    
        createOrder(merchant: merchant, items: items!, orderDate: orderDate!)
    }
    
    
    //MARK: - Cart Content
    
    func loadCartContent() {
        viewController?.updateCartItems(CartManager.shared.items)
    }
    
    
    //MARK: - Networking
    
    func createOrder(merchant: Merchant, items: [CartItem], orderDate: Date) {
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView(title: "Creating Order", subtitle: "Loading...")
        PKHUD.sharedHUD.show()
        
        ServiceManager.shared.createOrder(merchantId: merchant.id, with: items, orderDate: orderDate) {
            [weak self] success, message, order in
            
            PKHUD.sharedHUD.hide()
            
            guard order != nil else { return }
            
            CartManager.shared.clear()
            self?.viewController?.clearCart()
        }
    }
    
    
    //MARK: - Validation
    
    func validate(items: [CartItem]?, orderDate: Date?) -> (isValid: Bool, message: String?) {
        
        guard isValidCartContent(items: items) else {
            return (false, "Cart is empty")
        }
        
        guard isValidDate(orderDate) else {
            return (false, "Date is unselected")
        }
        return (true, nil)
    }
    
    func isValidCartContent(items: [CartItem]?) -> Bool {
        return items?.count ?? 0 > 0
    }
    
    func isValidDate(_ date: Date?) -> Bool {
        return date != nil
    }
}
