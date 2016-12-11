//
//  Interactor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 11.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class Interactor <T: UIViewController> {
    
    weak var viewController: T?
    
    init(viewController: T?) {
        self.viewController = viewController
    }
}
