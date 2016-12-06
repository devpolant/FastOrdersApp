//
//  MerchantsRouter.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 06.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class MerchantsRouter: Router {
    
    weak var viewController: MerchantsViewController?
    
    
    //MARK: - Parent
    
    func contentViewController() -> UIViewController? {
        return viewController
    }
    
}
