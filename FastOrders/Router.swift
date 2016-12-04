//
//  BaseRouter.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation
import UIKit

protocol Router {
    func contentViewController() -> UIViewController
}

//MARK: - Actions
extension Router {
    
    func dismiss(animated: Bool) {
        
        let contentVC = contentViewController()
        
        if let navigationController = contentVC.navigationController {
            navigationController.popViewController(animated: animated)
        } else {
            contentVC.dismiss(animated: animated, completion: nil)
        }
    }
}
