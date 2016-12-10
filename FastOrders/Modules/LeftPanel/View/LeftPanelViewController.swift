//
//  LeftPanelViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class LeftPanelViewController: UITableViewController {

    enum MenuIndex: Int {
        case avatar = 0
        case places = 1
        case orders = 2
        case cart   = 3
        case logout = 4
    }
    
    var interactor: LeftPanelInteractor!
    var router: LeftPanelRouter!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initVIPER()
        
        clearsSelectionOnViewWillAppear = false
    }
    
    func initVIPER() {
        interactor = LeftPanelInteractor(viewController: self)
        router = LeftPanelRouter(viewController: self)
    }

    
    //MARK: - Interactor
    
    func actionDidTapPlacesMenu() {
        interactor.actionDidTapPlacesMenu()
    }
    
    func actionDidTapOrdersMenu() {
        interactor.actionDidTapOrdersMenu()
    }
    
    func actionDidTapCartMenu() {
        interactor.actionDidTapCartMenu()
    }
    
    func actionDidTapLogout() {
        interactor.actionDidTapLogout()
    }
    
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let menuIndex = MenuIndex(rawValue: indexPath.row)!
        
        switch menuIndex {
        case .places:
            actionDidTapPlacesMenu()
        case .orders:
            actionDidTapOrdersMenu()
        case .cart:
            actionDidTapCartMenu()
        case .logout:
            actionDidTapLogout()
        default:
            break
        }
    }
    
}
