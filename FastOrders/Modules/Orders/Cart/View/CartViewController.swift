//
//  CartViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 11.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var orderDateTextField: UITextField!
    var datePicker: UIDatePicker!
    
    var interactor: CartInteractor!
    var router: CartRouter!
    
    var cartItems: [CartItem]?
    var orderDate: Date?
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        interactor.loadCartContent()
    }
    
    
    //MARK: - View
    
    func setupUI() {
        
        datePicker = UIDatePicker()
        
        datePicker.minimumDate = Date().addingTimeInterval(3600) //1 hour
        datePicker.datePickerMode = .dateAndTime
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneDatePickerPressed))
        
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        orderDateTextField.inputAccessoryView = toolBar
        
        orderDateTextField.inputView = datePicker
    }
    
    
    //MARK: - Interactor
    
    @IBAction func actionDidTapSaveBarItem(_ sender: Any) {
        interactor.actionSaveOrder(with: cartItems, orderDate: orderDate)
    }
    
    func doneDatePickerPressed(){
        orderDateTextField.resignFirstResponder()
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
    
    func clearCart() {
        
        self.cartItems = nil
        self.orderDate = nil
        self.orderDateTextField.text = ""
        
        tableView.reloadData()
    }
    
    
    //MARK: - Entity
    
    func cartItem(at indexPath: IndexPath) -> CartItem {
        return cartItems![indexPath.row]
    }
    
    
    //MARK: - Delegates
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        orderDate = datePicker.date
        textField.text = orderDate?.readableString
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        orderDate = datePicker.date
        textField.text = orderDate?.readableString
    }
    
    
    //MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRow(at: indexPath)
    }
    
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = CartSectionHeaderView(frame: CGRect(x: 0, y: 0,
                                                             width: tableView.frame.width,
                                                             height: 44))
        
        headerView.price = CartManager.shared.totalPrice
        
        return headerView
    }
    
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
