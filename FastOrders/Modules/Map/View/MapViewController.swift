//
//  MapViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Delegates
    
    //MARK: MKMapViewDelegate

    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        loadVisiblePlaces(of: mapView, completion: {(_ error: Error) -> Void in
            
        })
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        let annotationIentifier = "id"
        
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIentifier)
        if pin == nil {
            pin = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIentifier)
        } else {
            pin?.annotation = annotation
        }
        
        let merchant = annotation as! Merchant
        
        pin?.canShowCallout = true
        pin?.image = UIImage(named: "ic_map_pin_big")!
        pin?.layer.anchorPoint = CGPoint(x: CGFloat(0.5), y: CGFloat(1.0))
        
        //Right
        
        pin?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        
        //Detail
        
        let creationDateLabel = UILabel(frame: CGRect(x: CGFloat(0),
                                                      y: CGFloat(0),
                                                      width: CGFloat(50),
                                                      height: CGFloat(30)))
        
        
        creationDateLabel.text = merchant.subtitle
        creationDateLabel.font = UIFont.systemFont(ofSize: CGFloat(12.0))
        creationDateLabel.numberOfLines = 1
        creationDateLabel.baselineAdjustment = .alignBaselines
        creationDateLabel.clipsToBounds = true
        creationDateLabel.backgroundColor = UIColor.clear
        creationDateLabel.textColor = UIColor.lightGray
        creationDateLabel.textAlignment = .left
        
        pin?.detailCalloutAccessoryView = creationDateLabel
        
        return pin
    }
    
    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
    }
    
    
    func loadVisiblePlaces(of mapView: MKMapView, completion: @escaping (_ error: Error) -> Void) {
        
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
        
        //Request to server.
        self.sendRequestForViviblePosts(for: centerCooldinate,
                                        in: visibleRadius,
                                        completion: completion)
    }
    
    func sendRequestForViviblePosts(for location: CLLocationCoordinate2D,
                                    in radius: CLLocationDistance,
                                    completion: @escaping (_ error: Error) -> Void) {
        
        let location = Location(latitude: location.latitude,
                                longitude: location.longitude)
        
        ServiceManager.shared.loadPlaces(at: location, in: radius) { [weak self] success, message, merchants in
            
            guard let mapView = self?.mapView,
                let merchants = merchants else {
                    return
            }
            
            mapView.removeAnnotations(mapView.annotations)
            
            for merchant in merchants {
                mapView.addAnnotation(merchant)
            }
        }
    }
    
    func annotation(withIdentifier annotationIdentifier: String) -> Merchant? {
        
        for case let merchant as Merchant in self.mapView.annotations {
            if merchant.id == annotationIdentifier {
                return merchant
            }
        }
        return nil
    }
    
}
