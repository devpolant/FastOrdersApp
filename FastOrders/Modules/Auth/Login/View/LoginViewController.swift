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

    @IBOutlet var buttons: [UIButton]!
    
    
    var interactor: LoginInteractor!
    var router: LoginRouter!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        interactor.prepare(for: segue, sender: sender)
    }
    
    
    //MARK: - View
    
    func setupUI() {
        
        #if DEBUG
            setLoginText("polant")
            setPasswordText("qwerty")
        #endif
        
        setErrorText("")
    }
    
    
    //MARK: - Interactor
    
    @IBAction func actionDidTapLoginButton(_ sender: Any) {
        interactor.actionLogin(login: getLogin(), password: getPassword())
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
    
    func setLoginText(_ login: String) {
        loginTextField.text = login
    }
    
    func setPasswordText(_ password: String) {
        passwordTextField.text = password
    }
    
    func setErrorText(_ errorText: String) {
        errorLabel.text = "\(errorText != "" ? "*": "")\(errorText)"
    }
    
    func updateButtons(enabled: Bool) {
        
        for button in buttons {
            button.isEnabled = enabled
        }
    }
    
}
