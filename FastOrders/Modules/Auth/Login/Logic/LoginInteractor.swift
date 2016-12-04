//
//  LoginInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation

class LoginInteractor {
    
    weak var viewController: LoginViewController?
    
    //MARK: - Actions
    
    func actionLogin() {
        
    }
    
    func actionSignUp() {
        viewController?.router.presentRegistrationViewController()
    }
}
