//
//  LoginRouter.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation
import UIKit

class LoginRouter: Router {
    
    weak var viewController: LoginViewController?
    
    
    //MARK: - Parent
    
    func contentViewController() -> UIViewController? {
        return viewController
    }
    
    
    //MARK: - Actions
    
    func presentRegistrationViewController() {
        viewController?.performSegue(withIdentifier: "showRegistration", sender: nil)
    }
}
