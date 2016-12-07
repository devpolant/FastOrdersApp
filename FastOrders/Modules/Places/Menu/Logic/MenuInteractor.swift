//
//  MenuInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 06.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation
import PKHUD

class MenuInteractor {
    
    weak var viewController: MenuViewController?
    
    
    //MARK: Actions
    
    func actionDidSelectMenuCategory(_ category: MenuCategory) {
        viewController?.router.presentMenuItemsViewController(for: category)
    }
    
    
    //MARK: Networking
    
    func loadMenuCategories(for merchant: Merchant) {
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView(title: "Menu", subtitle: "Loading...")
        PKHUD.sharedHUD.show()
        
        ServiceManager.shared.loadMenuCategories(for: merchant) { [weak self] success, message, categories in
            
            PKHUD.sharedHUD.hide()
            
            guard let categories = categories else { return }
            
            self?.viewController?.updateMenuCategories(categories)
        }
    }
}
