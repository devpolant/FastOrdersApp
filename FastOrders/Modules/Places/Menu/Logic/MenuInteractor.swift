//
//  MenuInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 06.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation

class MenuInteractor {
    
    weak var viewController: MenuViewController?
    
    
    //MARK: Actions
    
    func actionDidSelectMenuCategory(_ category: MenuCategory) {
        
    }
    
    
    //MARK: Networking
    
    func loadMenuCategories(for merchant: Merchant) {
        
        ServiceManager.shared.loadMenuCategories(for: merchant) { [weak self] success, message, categories in
            
            guard let categories = categories else { return }
            
            self?.viewController?.updateMenuCategories(categories)
        }
    }
}
