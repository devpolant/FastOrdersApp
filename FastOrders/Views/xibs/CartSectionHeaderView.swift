//
//  CartSectionHeaderView.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 11.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class CartSectionHeaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!

    var price: Double = 0 {
        didSet {
            totalPriceLabel.text = "$\(price)"
        }
    }
    
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    
    func setup() {
        let nib = UINib(nibName: "CartSectionHeader", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(contentView)
    }
    
}
