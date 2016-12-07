//
//  MenuItemsInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 07.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation

class MenuItemsInteractor {
    
    weak var viewController: MenuItemsViewController?
    
    
    //MARK: Actions
    
    func actionDidSelectMenuItem(_ menuItem: MenuItem) {
        
    }
    
    
    //MARK: Networking
    
    func loadMenuItems(for category: MenuCategory) {
        
        ServiceManager.shared.loadMenuItems(for: category) { [weak self] success, message, menuItems in
            
            guard let menuItems = menuItems else { return }
            
            self?.viewController?.updateMenuItems(menuItems)
        }
    }
    
}
