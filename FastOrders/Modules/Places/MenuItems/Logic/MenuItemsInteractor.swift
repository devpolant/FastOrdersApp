//
//  MenuItemsInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 07.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation
import PKHUD

class MenuItemsInteractor : Interactor<MenuItemsViewController> {
    
    
    //MARK: - Actions
    
    func actionDidSelectMenuItem(_ menuItem: MenuItem) {
        viewController?.router.presentItemDetailsViewControleller(for: menuItem)
    }
    
    
    //MARK: - Networking
    
    func loadMenuItems(for category: MenuCategory) {
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView(title: "Menu Items", subtitle: "Loading...")
        PKHUD.sharedHUD.show()
        
        ServiceManager.shared.loadMenuItems(for: category) { [weak self] success, message, menuItems in
            
            PKHUD.sharedHUD.hide()
            
            guard let menuItems = menuItems else { return }
            
            self?.viewController?.updateMenuItems(menuItems)
        }
    }
    
}
