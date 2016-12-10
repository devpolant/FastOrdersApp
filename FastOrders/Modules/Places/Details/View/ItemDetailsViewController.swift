//
//  ItemDetailsViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 10.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    @IBOutlet weak var quantityTextField: UITextField!
    
    var interactor: ItemDetailsInteractor!
    var router: ItemDetailsRouter!
    
    var keyboardManager: KeyboardManager!
    
    var menuItem: MenuItem!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardManager = KeyboardManager(rootView: view, scrollView: scrollView, activeView: nil)
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        keyboardManager.registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        keyboardManager.unregisterForKeyboardNotifications()
    }
    
    
    //MARK: - View
    
    func setupUI() {
        updateImage(with: menuItem.photoUrl)
        updateItemName(menuItem.name)
        updateItemDescription(menuItem.description)
        updatePrice(menuItem.price)
    }
    
    
    //MARK: - Interactor
    
    @IBAction func actionDidTapAddToCartButton(_ sender: Any) {
        interactor.actionAddItemToCart(menuItem: menuItem, quantity: getSelectedQuantity())
    }
    
    
    //MARK: - Presenter
    
    func updateImage(with url: String?) {
        imageView.image = UIImage(named: "food_placeholder")
    }
    
    func updateItemName(_ name: String) {
        itemNameLabel.text = name
    }
    
    func updateItemDescription(_ description: String) {
        itemDescriptionTextView.text = description
    }
    
    func updatePrice(_ price: Double) {
        itemPriceLabel.text = "$\(price)"
    }
    
    func getSelectedQuantity() -> Int {
        
        if quantityTextField.text == nil || quantityTextField.text == "" {
            return 1
        }
        return Int(quantityTextField.text!)!
    }
    
    
    //MARK: - Delegates
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardManager.activeView = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyboardManager.activeView = nil
        return true
    }
}

