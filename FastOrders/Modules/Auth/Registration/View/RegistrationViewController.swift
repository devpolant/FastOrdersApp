//
//  RegistrationViewController.swift
//  FastOrders
//
//  Created by Anton Poltoratskyi on 04.12.16.
//  Copyright © 2016 Poltoratskyi Team. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    var textFields: [UITextField]!
    var keyboardManager: KeyboardManager!
    
    var interactor: RegistrationInteractor!
    var router: RegistrationRouter!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFields = [usernameTextField, loginTextField, passwordTextField, confirmPasswordTextField]
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
        
        #if DEBUG
            setUsernameText("John Appleseed")
            setLoginText("@johnappleseed")
            setPasswordText("qwerty")
            setConfirmedPasswordText("qwerty")
        #endif
        
        setErrorText("")
    }
    
    
    //MARK: - Interactor
    
    @IBAction func actionDidTapSignUpButton(_ sender: Any) {
        
        interactor.actionSignUp(name: getUsername(),
                                login: getLogin(),
                                password: getPassword(),
                                confirmedPassword: getConfirmedPassword())
    }
    
    
    //MARK: - Presenter
    
    func getUsername() -> String {
        return usernameTextField.text ?? ""
    }
    
    func getLogin() -> String {
        return loginTextField.text ?? ""
    }
    
    func getPassword() -> String {
        return passwordTextField.text ?? ""
    }
    
    func getConfirmedPassword() -> String {
        return confirmPasswordTextField.text ?? ""
    }
    
    func setUsernameText(_ username: String) {
        usernameTextField.text = username
    }
    
    func setLoginText(_ login: String) {
        loginTextField.text = login
    }
    
    func setPasswordText(_ password: String) {
        passwordTextField.text = password
    }
    
    func setConfirmedPasswordText(_ password: String) {
        confirmPasswordTextField.text = password
    }
    
    func setErrorText(_ errorText: String) {
        errorLabel.text = "\(errorText != "" ? "*": "")\(errorText)"
    }
    
    func updateButtons(enabled: Bool) {
        signUpButton.isEnabled = enabled
    }
    
    
    //MARK: - Delegates
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardManager.activeView = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let index = textFields.index(of: textField)!
        if index < textFields.count - 1{
            keyboardManager.activeView = textFields[index + 1]
        } else {
            keyboardManager.activeView = nil
        }
        
        return true
    }
}
