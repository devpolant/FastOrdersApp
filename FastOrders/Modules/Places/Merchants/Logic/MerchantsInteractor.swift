//
//  MerchantsInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 06.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation

class MerchantsInteractor {
    
    weak var viewController: MerchantsViewController?
    
    
    //MARK: Actions
    
    func actionDidSelectMerchant(_ merchant: Merchant) {
        viewController?.router.presentMenuViewController(for: merchant)
    }
    
    
    //MARK: Networking
    
    func loadPlaces() {
        
        ServiceManager.shared.loadAllPlaces { [weak self] success, message, merchants in
            
            guard let merchants = merchants else { return }
            
            self?.viewController?.updateMerchants(merchants)
        }
    }
}
