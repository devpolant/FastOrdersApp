//
//  RootRouter.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class RootRouter {
    
    weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigation = mainStoryboard.instantiateViewController(withIdentifier: "RootNavigationController") as! UINavigationController
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}
