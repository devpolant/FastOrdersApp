//
//  Merchant.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import Foundation
import MapKit

final class Merchant: NSObject, MKAnnotation {
    
    var id: String
    var businessName: String
    var country: String
    var city: String
    var address: String
    var location: Location
    var visitorsCount: Int?
    
    
    init(id: String, businessName: String, country: String, city: String, address: String, location: Location, visitorsCount: Int? = nil) {
        
        self.id = id
        self.businessName = businessName
        self.country = country
        self.city = city
        self.address = address
        self.location = location
        self.visitorsCount = visitorsCount
    }
    
    convenience init(from json: [String: Any]) {
        self.init(id: json["_id"] as! String,
                  businessName: json["business_name"] as! String,
                  country: json["country"] as! String,
                  city: json["city"] as! String,
                  address: json["address"] as! String,
                  location: Location(latitude: json["latitude"] as! Double,
                                     longitude: json["longitude"] as! Double),
                  visitorsCount: json["visitors_count"] as! Int?)
    }
    
    
    //MARK: - MKAnnotation
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
    
    var title: String? {
        return businessName
    }
    
    var subtitle: String? {
        return "\(city), \(address)"
    }
}
