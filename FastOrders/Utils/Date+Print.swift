//
//  Date+Print.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation

extension Date {
    
    var readableString: String {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH:mm dd/MM/yyyy"
        return formatter.string(from: self)
    }
    
}
