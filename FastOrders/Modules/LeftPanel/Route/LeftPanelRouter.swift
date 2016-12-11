//
//  LeftPanelRouter.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class LeftPanelRouter: Router<LeftPanelViewController> {

    
    //MARK: - Routes
    
    override func dismiss(animated: Bool) {
        
        if let navigationController = viewController?.sidePanelController.navigationController {
            navigationController.popViewController(animated: animated)
        } else {
            viewController?.sidePanelController.dismiss(animated: animated, completion: nil)
        }
    }
    
    func presentPlaces() {
        
        let contentStoryboard = UIStoryboard(name: "Content", bundle: nil)
        
        let initialVC = contentStoryboard.instantiateInitialViewController()!
        
        viewController?.sidePanelController.centerPanel = initialVC
    }
    
    func presentOrders() {
        
        let storyboard = UIStoryboard(name: "Orders", bundle: nil)
        
        let navigation = storyboard.instantiateInitialViewController() as! UINavigationController
        let ordersListVC = navigation.viewControllers.first as! OrdersViewController
        
        ordersListVC.interactor = OrdersInteractor(viewController: ordersListVC)
        ordersListVC.router = OrdersRouter(viewController: ordersListVC)
        
        viewController?.sidePanelController.centerPanel = navigation
    }
    
    func presentCart() {
        
        let storyboard = UIStoryboard(name: "Cart", bundle: nil)
        
        let navigation = storyboard.instantiateInitialViewController() as! UINavigationController
        let cartVC = navigation.viewControllers.first as! CartViewController
        
        cartVC.interactor = CartInteractor(viewController: cartVC)
        cartVC.router = CartRouter(viewController: cartVC)
        
        viewController?.sidePanelController.centerPanel = navigation
    }
}
