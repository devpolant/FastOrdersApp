//
//  MerchantsViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 06.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class MerchantsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var interactor: MerchantsInteractor!
    var router: MerchantsRouter!
    
    @IBOutlet weak var tableView: UITableView!
    
    var merchants = [Merchant]()
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVIPER()
        
        interactor.loadPlaces()
    }
    
    func initVIPER() {
    
        interactor = MerchantsInteractor()
        interactor.viewController = self
        
        router = MerchantsRouter()
        router.viewController = self
    }
    
    
    //MARK: - Presenter
    
    func cellForRow(at indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "merchantCell"
        
        let merchant = self.merchant(at: indexPath)
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? MerchantTableViewCell
        
        if cell == nil {
            cell = MerchantTableViewCell()
        }
        cell?.businessNameLabel.text = merchant.businessName
        cell?.addressLabel.text = merchant.address
        cell?.merchantAvatarImageView.image = UIImage(named: "watch")
        
        return cell!
    }
    
    func updateMerchants(_ merchants: [Merchant]) {
        self.merchants = merchants
        tableView.reloadData()
    }
    
    
    //MARK: - Entity
    
    func merchant(at indexPath: IndexPath) -> Merchant {
        return merchants[indexPath.row]
    }
    
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return merchants.count
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
        
        let merchant = self.merchant(at: indexPath)
        interactor.actionDidSelectMerchant(merchant)
    }
}
