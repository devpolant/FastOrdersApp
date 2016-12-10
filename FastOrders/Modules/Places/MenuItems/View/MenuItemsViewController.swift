//
//  MenuItemsViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 07.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class MenuItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var interactor: MenuItemsInteractor!
    var router: MenuItemsRouter!
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var menuItems = [MenuItem]()
    
    var category: MenuCategory!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setComposeBarButtonItem()
        updateEditingEnableState()
        interactor.loadMenuItems(for: category)
    }
    
    
    //MARK: - Interactor
    
    func actionDidTapStartEditingBarButtonItem(_ sender: UIBarButtonItem) {
        beginEditingTable()
    }
    
    func actionDidTapEndEditingBarButtonItem(_ sender: UIBarButtonItem) {
        endEditingTable()
    }
    

    //MARK: - Presenter
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "menuItemCell"
        
        let menuItem = self.menuItem(at: indexPath)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? MenuItemTableViewCell
        
        if cell == nil {
            cell = MenuItemTableViewCell()
        }
        cell?.menuItemPhotoImageView.image = UIImage(named: "watch")
        cell?.menuItemNameLabel.text = menuItem.name
        cell?.menuItemDescriptionLabel.text = menuItem.description
        cell?.menuItemPriceLabel.text = "$\(menuItem.price)"
        
        return cell!
    }
    
    func updateMenuItems(_ menuItems: [MenuItem]) {
        self.menuItems = menuItems
        updateEditingEnableState()
        tableView.reloadData()
    }
    
    func beginEditingTable() {
        tableView.setEditing(true, animated: true)
        setDoneBarButtonItem()
    }
    
    func endEditingTable() {
        tableView.setEditing(false, animated: true)
        setComposeBarButtonItem()
    }

    func setDoneBarButtonItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                 target: self,
                                                                 action: #selector(endEditingTable))
    }
    
    func setComposeBarButtonItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                                 target: self,
                                                                 action: #selector(beginEditingTable))
    }
    
    func updateEditingEnableState() {
        self.navigationItem.rightBarButtonItem?.isEnabled = canEnableEditing()
    }
    
    func canEnableEditing() -> Bool {
        return menuItems.count > 0
    }
    
    
    //MARK: - Entity
    
    func menuItem(at indexPath: IndexPath) -> MenuItem {
        return menuItems[indexPath.row]
    }
    
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRow(at: indexPath)
    }
    
    
    //MARK: - Delegates
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .insert
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.menuItem(at: indexPath)
        interactor.actionDidSelectMenuItem(item)
    }

}
