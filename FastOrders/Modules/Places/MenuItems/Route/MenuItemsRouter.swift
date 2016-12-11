//
//  MenuItemsRouter.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 07.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class MenuItemsRouter: Router<MenuItemsViewController> {
    
    
    //MARK: - Routing
    
    func presentItemDetailsViewControleller(for menuItem: MenuItem) {
        
        let storyboard = UIStoryboard(name: "Content", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "ItemDetailsViewController") as! ItemDetailsViewController
        
        vc.interactor = ItemDetailsInteractor(viewController: vc)
        vc.router = ItemDetailsRouter(viewController: vc)
        
        vc.menuItem = menuItem
        
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
