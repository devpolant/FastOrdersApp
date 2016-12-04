//
//  LoginViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!

    var interactor: LoginInteractor!
    var router: LoginRouter!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Interactor
    
    @IBAction func actionDidTapLoginButton(_ sender: Any) {
        interactor.actionLogin()
    }
    
    @IBAction func actionDidTapSignUpButton(_ sender: Any) {
        interactor.actionSignUp()
    }
    
    
    //MARK: - Presenter
    
    func getLogin() -> String {
        return loginTextField.text ?? ""
    }
    
    func getPassword() -> String {
        return passwordTextField.text ?? ""
    }
    
    func setErrorText(_ errorText: String) {
        errorLabel.text = "*\(errorText)"
    }
    
}
