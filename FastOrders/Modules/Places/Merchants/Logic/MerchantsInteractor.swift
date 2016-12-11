//
//  MerchantsInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 06.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation
import PKHUD

class MerchantsInteractor : Interactor<MerchantsViewController> {
    
    
    //MARK: Actions
    
    func actionDidSelectMerchant(_ merchant: Merchant) {
        viewController?.router.presentMenuViewController(for: merchant)
    }
    
    
    //MARK: Networking
    
    func loadPlaces() {
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView(title: "Places", subtitle: "Loading...")
        PKHUD.sharedHUD.show()
        
        ServiceManager.shared.loadAllPlaces { [weak self] success, message, merchants in
            
            PKHUD.sharedHUD.hide()
            
            guard let merchants = merchants else { return }
            
            self?.viewController?.updateMerchants(merchants)
        }
    }
}
