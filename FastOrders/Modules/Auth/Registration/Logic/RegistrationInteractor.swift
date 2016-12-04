//
//  RegistrationInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation
import PKHUD

class RegistrationInteractor {
    
    weak var viewController: RegistrationViewController?
    
    
    //MARK: - Actions
    
    func actionSignUp(name: String, login: String, password: String, confirmedPassword: String) {
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView(title: "Signing Up", subtitle: "Loading...")
        PKHUD.sharedHUD.show()
        
        self.viewController?.updateButtons(enabled: false)
        
        ServiceManager.shared.sendRegister(name: name,
                                           login: login,
                                           password: password) { [weak self] success, message in
            
            self?.viewController?.updateButtons(enabled: true)
                                          
            PKHUD.sharedHUD.hide()
                                            
            if success {
                self?.viewController?.router.presentMapViewController()
            } else {
                self?.viewController?.setErrorText(message)
            }
        }
    }
}
