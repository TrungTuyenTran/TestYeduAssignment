//
//  UIViewController + Extensions.swift
//  TestAsignment
//
//  Created by Tran Tuyen on 27/06/2022.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.handleDismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleDismissKeyboard() {
        view.endEditing(true)
    }
}
