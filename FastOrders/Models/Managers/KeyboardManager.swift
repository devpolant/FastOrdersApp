//
//  KeyboardManager.swift
//  iOSUtils
//
//  Created by Anton Poltoratskyi on 02.10.16.
//  Copyright © 2016 Appus. All rights reserved.
//

import Foundation
import UIKit

class KeyboardManager : NSObject {
    
    fileprivate weak var rootView : UIView?
    fileprivate weak var scrollView : UIScrollView?
    
    public weak var activeView : UIView? {
        
        willSet (newActiveView) {
            
            if newActiveView == nil {
                activeView?.resignFirstResponder()
            }
        }
        didSet {
            
            if activeView != nil && !(activeView?.isFirstResponder)! {
                activeView?.becomeFirstResponder()
            }
        }
    }
    
    init(rootView: UIView?, scrollView: UIScrollView?, activeView: UIView?) {
        
        self.rootView = rootView
        self.scrollView = scrollView
        self.activeView = activeView
        super.init()
        
        let tapOnRootRecognizer = UIGestureRecognizer(target: self,
                                                      action:#selector(tapOnWhiteSpace(recognizer:)))
        
        self.rootView?.addGestureRecognizer(tapOnRootRecognizer)
    }
    
    
    //MARK: Public API
    
    public func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardDidShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    public func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: Keyboard
    
    @objc fileprivate func keyboardDidShow(notification: Notification) {
        
        guard let dictionary = notification.userInfo,
            let keyboardSize = (dictionary[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
        
        // If active text field is hidden by keyboard, scroll it so it's visible.
        
        if let activeViewFrame = activeView?.frame, var rootFrame = rootView?.frame {
            
            guard let activeRect = activeView?.superview?.convert(activeViewFrame, to: scrollView) else {
                return
            }
            
            rootFrame.size.height -= keyboardSize.height
            
            if !(rootFrame.contains(activeRect)) {
                scrollView?.scrollRectToVisible(activeRect, animated: true)
            }
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: Notification) {
        
        let contentInsets = UIEdgeInsets()
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    
    //MARK: Root View
    
    @objc fileprivate func tapOnWhiteSpace(recognizer: UITapGestureRecognizer) {
        activeView = nil
    }
}
