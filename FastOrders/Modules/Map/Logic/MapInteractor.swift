//
//  MapInteractor.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit
import MapKit

class MapInteractor {
    
    weak var viewController: MapViewController?
    
    
    //MARK: - Actions
    
    func regionDidChange(in mapView: MKMapView) {
        
        let (mapCenterLocation, visibleRadius) = visibleMetrics(for: mapView)
        
        loadVisiblePlaces(for: mapCenterLocation, in: visibleRadius)
    }
    
    func actionDidSelectPlaceAnnotation(for merchant: Merchant) {
        viewController?.router.presentMenuViewController(for: merchant)
    }
    
    
    //MARK: MapView Calculations
    
    func visibleMetrics(for mapView: MKMapView) -> (center: Location, radius: Double) {
        
        let topLeftPoint = CGPoint(x: CGFloat(mapView.bounds.origin.x),
                                   y: CGFloat(mapView.bounds.origin.y))
        
        let bottomLeftPoint = CGPoint(x: CGFloat(mapView.bounds.origin.x),
                                      y: CGFloat(mapView.bounds.origin.y + mapView.bounds.size.height))
        
        let centerPoint = CGPoint(x: CGFloat(mapView.bounds.origin.x + mapView.bounds.size.width / 2),
                                  y: CGFloat(mapView.bounds.origin.y + mapView.bounds.size.height / 2))
        
        //Transform points into lat/long values.
        
        let topLeftCooldinate = mapView.convert(topLeftPoint, toCoordinateFrom: mapView)
        let bottomLeftCooldinate = mapView.convert(bottomLeftPoint, toCoordinateFrom: mapView)
        let centerCooldinate = mapView.convert(centerPoint, toCoordinateFrom: mapView)
        
        //Calculate distance between left and right coordinates.
        
        let topLeftMapPoint = MKMapPointForCoordinate(topLeftCooldinate)
        let bottomLeftMapPoint = MKMapPointForCoordinate(bottomLeftCooldinate)
        let visibleRadius = MKMetersBetweenMapPoints(topLeftMapPoint, bottomLeftMapPoint) / 2
        
        
        let location = Location(latitude: centerCooldinate.latitude,
                                longitude: centerCooldinate.longitude)
        
        return (location, visibleRadius)
    }
    
    
    //MARK: Networking
    
    func loadVisiblePlaces(for location: Location, in radius: CLLocationDistance) {
        
        ServiceManager.shared.loadPlaces(at: location, in: radius) { [weak self] success, message, merchants in
            
            guard let merchants = merchants else { return }
            
            self?.viewController?.updateAnnotations(merchants)
        }
    }
    
}
