//
//  ContainerViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class ContainerViewController: JASidePanelController {

    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let contentStoryboard = UIStoryboard(name: "Content", bundle: nil)
        
        let leftVC = contentStoryboard.instantiateViewController(withIdentifier: "LeftPanelViewController")
        let centerVC = contentStoryboard.instantiateViewController(withIdentifier: "PlacesTabBarViewController")
        
        leftPanel = leftVC
        centerPanel = centerVC
        
        shouldResizeLeftPanel = true
        panningLimitedToTopViewController = false
    }
    
    
    //MARK: - JASidePanelController
    
    override func leftButtonForCenterPanel() -> UIBarButtonItem! {
        
        let toggleImage = UIImage(named: "ic_burger")
        
        let barItem = UIBarButtonItem(image: toggleImage,
                                      style: .plain,
                                      target: self,
                                      action: #selector(toggleLeftPanel(_:)))
        
        return barItem
    }
    
}
