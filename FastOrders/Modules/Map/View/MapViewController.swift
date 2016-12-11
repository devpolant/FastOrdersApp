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
    
    var interactor: MapInteractor!
    var router: MapRouter!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor = MapInteractor(viewController: self)
        
        router = MapRouter()
        router.viewController = self
    }
    
    
    //MARK: - Presenter
    
    func updateAnnotations(_ places: [Merchant]) {
        
        mapView.removeAnnotations(mapView.annotations)
        
        for merchant in places {
            mapView.addAnnotation(merchant)
        }
    }
    
    
    //MARK: - Entity
    
    func annotation(withIdentifier annotationIdentifier: String) -> Merchant? {
        
        for case let merchant as Merchant in self.mapView.annotations {
            if merchant.id == annotationIdentifier {
                return merchant
            }
        }
        return nil
    }
    
    
    //MARK: - Delegates
    
    //MARK: MKMapViewDelegate

    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        interactor.regionDidChange(in: mapView)
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
        
        
        //Left
        
        let imageView = UIImageView(frame: CGRect(origin: CGPoint.zero,
                                                  size: CGSize(width: 30, height: 30)))
        imageView.image = UIImage(named: "watch")
        
        pin?.leftCalloutAccessoryView = imageView
        
        
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
    
        let merchant = view.annotation as! Merchant
        interactor.actionDidSelectPlaceAnnotation(for: merchant)
    }
    
}
