//
//  CartInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 11.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class CartInteractor {

    weak var viewController: CartViewController?
    
    init(viewController: CartViewController?) {
        self.viewController = viewController
    }
    
    
    //MARK: - Local Data
    
    func loadCartContent() {
        viewController?.updateCartItems(CartManager.shared.items)
    }
    
}
