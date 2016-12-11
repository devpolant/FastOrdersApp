//
//  OrdersInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit
import PKHUD

class OrdersInteractor {
    
    weak var viewController: OrdersViewController?
    
    init(viewController: OrdersViewController?) {
        self.viewController = viewController
    }
    
    
    //MARK: - Actions
    
    func actionDidSelectOrder(_ order: Order) {
        viewController?.router.presentOrderItemsViewController(for: order)
    }
    
    
    //MARK: - Networking
    
    func loadOrders() {
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView(title: "My Orders", subtitle: "Loading...")
        PKHUD.sharedHUD.show()
        
        ServiceManager.shared.loadOrders { [weak self] success, message, orders in
            
            PKHUD.sharedHUD.hide()
            
            guard let orders = orders else { return }
            
            self?.viewController?.updateOrders(orders)
        }
    }
}
