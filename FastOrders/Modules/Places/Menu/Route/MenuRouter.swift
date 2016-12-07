//
//  MenuRouter.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 06.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class MenuRouter: Router {
    
    weak var viewController: MenuViewController?
    
    
    //MARK: - Parent
    
    func contentViewController() -> UIViewController? {
        return viewController
    }
    
    
    //MARK: - Routes
    
    func presentMenuItemsViewController(for category: MenuCategory) {
        
        let storyboard = UIStoryboard(name: "Content", bundle: nil)
        
        let menuVC = storyboard.instantiateViewController(withIdentifier: "MenuItemsViewController") as! MenuItemsViewController
        
        menuVC.interactor = MenuItemsInteractor()
        menuVC.interactor.viewController = menuVC
        
        menuVC.router = MenuItemsRouter()
        menuVC.router.viewController = menuVC
        
        menuVC.category = category
        
        viewController?.navigationController?.pushViewController(menuVC, animated: true)
    }
}
