//
//  OrdersRouter.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class OrdersRouter: Router {

    weak var viewController: OrdersViewController?
    
    init(viewController: OrdersViewController?) {
        self.viewController = viewController
    }
    
    
    //MARK: - Parent
    
    func contentViewController() -> UIViewController? {
        return viewController
    }
    
    
    //MARK: - Routing
    
    func presentOrderItemsViewController(for order: Order) {
        
        let storyboard = UIStoryboard(name: "Orders", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "OrderItemsViewController") as! OrderItemsViewController
        
        vc.order = order
        
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
