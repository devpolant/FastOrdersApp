//
//  JsonInitializable.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation

protocol JsonInitializable {
    init(from dictionary: [String: Any])
}
