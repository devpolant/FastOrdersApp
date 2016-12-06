//
//  MenuViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 06.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var interactor: MenuInteractor!
    var router: MenuRouter!
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var menuCategories = [MenuCategory]()
    var merchant: Merchant!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVIPER()
    }
    
    func initVIPER() {
        
        interactor = MenuInteractor()
        interactor.viewController = self
        
        router = MenuRouter()
        router.viewController = self
    }
    
    
    //MARK: - Presenter
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "categoryCell"
        
        let category = self.category(at: indexPath)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? MenuCategoryTableViewCell
        
        if cell == nil {
            cell = MenuCategoryTableViewCell()
        }
        cell?.categoryPhotoImageView.image = UIImage(named: "watch")
        cell?.categoryNameLabel.text = category.name
        cell?.categoryDescriptionLabel.text = category.description
        
        return cell!
    }
    
    func updateMenuCategories(_ menuCategories: [MenuCategory]) {
        
    }
    
    
    //MARK: - Entity
    
    func category(at indexPath: IndexPath) -> MenuCategory {
        return menuCategories[indexPath.row]
    }
    
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRow(at: indexPath)
    }
    
    
    //MARK: - Delegates
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let category = self.category(at: indexPath)
        interactor.actionDidSelectMenuCategory(category)
    }
}
