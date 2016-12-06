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
    
//    func loadPlaces() {
//        
//        ServiceManager.shared.loadAllPlaces { [weak self] success, message, merchants in
//            
//            guard let merchants = merchants else { return }
//            
//            self?.viewController?.updateMerchants(merchants)
//        }
//    }
}
