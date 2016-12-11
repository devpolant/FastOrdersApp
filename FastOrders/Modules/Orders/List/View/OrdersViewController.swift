//
//  OrdersViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var interactor: OrdersInteractor!
    var router: OrdersRouter!
    
    var orders: [Order]?
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor.loadOrders()
    }
    
    
    //MARK: - Presenter
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "orderCell"
        
        let order = self.order(at: indexPath)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? OrderTableViewCell
        
        if cell == nil {
            cell = OrderTableViewCell()
        }
        cell?.merchantBusinessNameLabel.text = order.merchant.businessName
        cell?.merchantAvatarImageView.image = UIImage(named: "watch")
        
        cell?.orderItemsCountLabel.text = String(order.orderItems.count)
        cell?.totalPriceLabel.text = "$\(order.totalPrice)"
        cell?.orderDateLabel.text = order.availabilityDate.readableString
        
        cell?.orderStateLabel.text = order.state.rawValue.capitalized
        
        return cell!
    }
    
    func updateOrders(_ orders: [Order]) {
        self.orders = orders
        tableView.reloadData()
    }
    
    
    //MARK: - Entity
    
    func order(at indexPath: IndexPath) -> Order {
        return orders![indexPath.row]
    }
    
    
    //MARK: - Delegates
    
    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.count ?? 0
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
        
        let order = self.order(at: indexPath)
        interactor.actionDidSelectOrder(order)
    }
    
}
