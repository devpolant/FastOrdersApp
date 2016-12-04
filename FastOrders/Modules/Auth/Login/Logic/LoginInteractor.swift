//
//  LoginInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit
import PKHUD

class LoginInteractor {
    
    weak var viewController: LoginViewController?
    
    
    //MARK: - Actions
    
    func actionLogin(login: String, password: String) {
        
        let (valid, error) = validate(login: login, password: password)
        
        guard valid else {
            self.viewController?.setErrorText(error!)
            return
        }
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView(title: "Logging in", subtitle: "Loading...")
        PKHUD.sharedHUD.show()
        
        self.viewController?.updateButtons(enabled: false)
        
        ServiceManager.shared.sendLogin(login: login,
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
    
    func actionSignUp() {
        viewController?.router.presentRegistrationViewController()
    }
    
    
    //MARK: - Segue
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        viewController?.router.prepare(for: segue, sender: nil)
    }
    
    
    //MARK: - Validation
    
    func validate(login: String, password: String) -> (success: Bool, error: String?){
        
        guard isValidLogin(login) else {
            return (false, "Invalid login")
        }
        
        guard isValidPassword(password) else {
            return (false, "Invalid password")
        }
        
        return (true, nil)
    }
    
    func isValidLogin(_ login: String) -> Bool {
        return login != ""
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password != ""
    }
}
