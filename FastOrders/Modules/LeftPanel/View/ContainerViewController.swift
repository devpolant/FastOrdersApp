//
//  ContainerViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class ContainerViewController: JASidePanelController {

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
    
    override func leftButtonForCenterPanel() -> UIBarButtonItem! {
        
        let toggleImage = UIImage(named: "ic_burger")
        
        let barItem = UIBarButtonItem(image: toggleImage,
                                      style: .plain,
                                      target: self,
                                      action: #selector(toggleLeftPanel(_:)))
        
        return barItem
    }
    
//    
//    -(void)awakeFromNib {
//    
//    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"LeftSideMenuPanelController"]];
//    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"CenterPanelNavigationController"]];
//    
//    //Set auto resizing left navigation menu panel.
//    self.shouldResizeLeftPanel = YES;
//    
//    //Set enable swipe for left panel after pushing new view controller in center container.
//    self.panningLimitedToTopViewController = NO;
//    }
//    
//    - (UIBarButtonItem *)leftButtonForCenterPanel {
//    
//    UIImage* backNavigationImage = [UIImage imageNamed:@"ic_burger"];
//    
//    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:backNavigationImage
//    style:UIBarButtonItemStylePlain
//    target:self
//    action:@selector(toggleLeftPanel:)];
//    
//    return barItem;
//    }

}
