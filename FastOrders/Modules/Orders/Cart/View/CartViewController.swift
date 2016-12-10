//
//  CartViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 11.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: CartInteractor!
    var router: CartRouter!
    
    var cartItems: [CartItem]?
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.loadCartContent()
    }
    
    
    //MARK: - Presenter
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "cartCell"
        
        let item = self.cartItem(at: indexPath)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? CartTableViewCell
        
        if cell == nil {
            cell = CartTableViewCell()
        }
        
        cell?.menuItemImageView.image = UIImage(named: "watch")
        cell?.menuItemNameLabel.text = item.menuItem.name
        
        cell?.quantityLabel.text = String(item.quantity)
        cell?.priceLabel.text = "$\(item.menuItem.price)"
        
        return cell!
    }
    
    func updateCartItems(_ items: [CartItem]) {
        self.cartItems = items
        tableView.reloadData()
    }
    
    
    //MARK: - Entity
    
    func cartItem(at indexPath: IndexPath) -> CartItem {
        return cartItems![indexPath.row]
    }
    
    
    //MARK: - Delegates
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRow(at: indexPath)
    }
    
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let item = cartItem(at: indexPath)
            
            CartManager.shared.deleteItemFromCart(item: item)
            cartItems = CartManager.shared.items
            
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
