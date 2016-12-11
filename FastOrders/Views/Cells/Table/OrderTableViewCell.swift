//
//  OrderTableViewCell.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var merchantAvatarImageView: UIImageView!
    @IBOutlet weak var merchantBusinessNameLabel: UILabel!
    
    @IBOutlet weak var orderItemsCountLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var orderDateLabel: UILabel!
    
    @IBOutlet weak var orderStateLabel: UILabel!
    
}
