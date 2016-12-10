//
//  LeftPanelRouter.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class LeftPanelRouter: Router {
    
    weak var viewController: LeftPanelViewController?
    
    init(viewController: LeftPanelViewController?) {
        self.viewController = viewController
    }
    
    
    //MARK: - Parent
    
    func contentViewController() -> UIViewController? {
        return viewController
    }
    
    
    //MARK: - Routes
    
    func dismiss(animated: Bool) {
        
        if let navigationController = viewController?.sidePanelController.navigationController {
            navigationController.popViewController(animated: animated)
        } else {
            viewController?.sidePanelController.dismiss(animated: animated, completion: nil)
        }
    }
    
    func presentPlaces() {
        
        let contentStoryboard = UIStoryboard(name: "Content", bundle: nil)
        
        let initialVC = contentStoryboard.instantiateInitialViewController()!
        
        viewController?.present(initialVC, animated: true, completion: nil)
    }
    
    func presentOrders() {
        
    }
    
    func presentCart() {
        
    }
}
