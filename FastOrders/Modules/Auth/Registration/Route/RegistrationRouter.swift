//
//  RegistrationRouter.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation
import UIKit

class RegistrationRouter: Router {
    
    weak var viewController: RegistrationViewController?
    
    func contentViewController() -> UIViewController? {
        return viewController
    }
}
