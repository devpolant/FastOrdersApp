//
//  LeftPanelInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit
import PKHUD

class LeftPanelInteractor : Interactor<LeftPanelViewController> {
    
    private var logoutLoading = false
    
    
    //MARK: - Actions
    
    func actionDidTapPlacesMenu() {
        viewController?.router.presentPlaces()
    }
    
    func actionDidTapOrdersMenu() {
        viewController?.router.presentOrders()
    }
    
    func actionDidTapCartMenu() {
        viewController?.router.presentCart()
    }
    
    func actionDidTapLogout() {
        logout()
    }
    
    
    //MARK: - Networking
    
    func logout() {
        
        guard !logoutLoading else { return }
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView(title: "Logout", subtitle: "Loading...")
        PKHUD.sharedHUD.show()
        
        ServiceManager.shared.sendLogout { [weak self] success, message in

            self?.logoutLoading = false
            
            PKHUD.sharedHUD.hide()
            
            if success {
                self?.viewController?.router.dismiss(animated: true)
            } else {
                self?.viewController?.showAlert(title: "Message", message: "Logout Failed")
            }
        }
    }
    
}
