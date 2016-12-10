//
//  LeftPanelInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class LeftPanelInteractor {
    
    weak var viewController: LeftPanelViewController?
    
    
    init(viewController: LeftPanelViewController?) {
        self.viewController = viewController
    }
    
    
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
        
    }
    
}
