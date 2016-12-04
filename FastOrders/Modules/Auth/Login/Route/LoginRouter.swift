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
    
    func presentMapViewController() {
        
        let contentStoryboard = UIStoryboard(name: "Content", bundle: nil)
        
        let initialVC = contentStoryboard.instantiateInitialViewController()!
        
        viewController?.present(initialVC, animated: true, completion: nil)
    }

    
    
    //MARK: - Segue
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
            
        case "showRegistration":
            
            let vc = segue.destination as! RegistrationViewController
            
            vc.interactor = RegistrationInteractor()
            vc.interactor.viewController = vc
            
            vc.router = RegistrationRouter()
            vc.router.viewController = vc
            
        default:
            break
        }
    }
}
