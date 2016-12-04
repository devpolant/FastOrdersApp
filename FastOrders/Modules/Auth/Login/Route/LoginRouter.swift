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
    
    var viewController: LoginViewController!
    
    func contentViewController() -> UIViewController {
        return viewController
    }
}
