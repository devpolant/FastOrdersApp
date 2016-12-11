//
//  OrderItemsViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 11.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class OrderItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var order: Order!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Presenter
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "orderItemCell"
        
        let orderItem = self.orderItem(at: indexPath)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? OrderItemTableViewCell
        
        if cell == nil {
            cell = OrderItemTableViewCell()
        }
        cell?.menuItemImageView.image = UIImage(named: "watch")
        cell?.menuItemNameLabel.text = orderItem.menuItem.name
        
        cell?.quantityLabel.text = String(orderItem.quantity)
        cell?.priceLabel.text = "$\(orderItem.menuItem.price)"
        
        return cell!
    }
    
    
    //MARK: - Entity
    
    func orderItem(at indexPath: IndexPath) -> OrderItem {
        return order.orderItems[indexPath.row]
    }
    
    
    //MARK: - Delegates
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRow(at: indexPath)
    }
    
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
