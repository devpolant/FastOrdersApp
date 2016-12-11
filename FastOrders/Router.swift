//
//  BaseRouter.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation
import UIKit

class Router <T: UIViewController> {
    
    weak var viewController: T?
    
    init(viewController: T?) {
        self.viewController = viewController
    }
    
    
    //MARK: - Actions
    
    func dismiss(animated: Bool) {
        
        guard let contentVC = viewController else { return }
        
        if let navigationController = contentVC.navigationController {
            navigationController.popViewController(animated: animated)
        } else {
            contentVC.dismiss(animated: animated, completion: nil)
        }
    }
}

