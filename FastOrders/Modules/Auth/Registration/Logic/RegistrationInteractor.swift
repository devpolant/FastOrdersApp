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
        
        let (valid, error) = validate(username: name, login: login, password: password, confirmedPassword: confirmedPassword)
        
        guard valid else {
            self.viewController?.setErrorText(error!)
            return
        }
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView(title: "Signing Up", subtitle: "Loading...")
        PKHUD.sharedHUD.show()
        
        self.viewController?.updateButtons(enabled: false)
        
        ServiceManager.shared.sendRegister(name: name,
                                           login: login,
                                           password: password) { [weak self] success, message in
            
            self?.viewController?.updateButtons(enabled: true)
                                          
            PKHUD.sharedHUD.hide()
                                            
            if success {
                self?.viewController?.setErrorText("")
                self?.viewController?.router.presentMapViewController()
            } else {
                self?.viewController?.setErrorText(message)
            }
        }
    }
    
    
    //MARK: - Validation
    
    func validate(username: String, login: String, password: String, confirmedPassword: String)
        -> (success: Bool, error: String?){

        guard isValidUsername(username) else {
            return (false, "Invalid username")
        }
        
        guard isValidLogin(login) else {
            return (false, "Invalid login")
        }
        
        guard isValidPassword(password) else {
            return (false, "Invalid password")
        }
            
        guard password == confirmedPassword else {
            return (false, "Password doesn't match")
        }
        
        return (true, nil)
    }

    func isValidUsername(_ username: String) -> Bool {
        return username != ""
    }
    
    func isValidLogin(_ login: String) -> Bool {
        return login != ""
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password != ""
    }
}
