//
//  CartRouter.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 11.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class CartRouter: Router {
    
    weak var viewController: CartViewController?
    
    init(viewController: CartViewController?) {
        self.viewController = viewController
    }
    
    
    //MARK: - Parent
    
    func contentViewController() -> UIViewController? {
        return viewController
    }
    
}
