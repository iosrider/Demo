//
//  ViewController.swift
//  HsbcTest
//
//  Created by Ankit Vyas on 10/08/19.
//  Copyright © 2019 Ankit Vyas. All rights reserved.
//

import UIKit
import KRProgressHUD


class SignInController: UIViewController {
    
    private var authToken = ""
    private var viewModel = LoginViewModel(userName: "", password: "")
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var userNameTextField: BindingTextField! {
        didSet {
            userNameTextField.bind { self.viewModel.userName = $0 }
        }
    }
    @IBOutlet weak var passwordTextField: BindingTextField! {
        didSet {
            passwordTextField.bind {self.viewModel.password = $0 }
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
        [userNameTextField, passwordTextField].forEach { (field) in
            field?.addTarget(self,action: #selector(editingChanged(_:)), for: .editingChanged)
        }
        
        Helper.addAllCornerRadious(loginView, radious: 5.0)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let userName    = userNameTextField.text,   !userName.isEmpty,
            let password   = passwordTextField.text,  !password.isEmpty
        else {
                self.loginButton.isEnabled = false
                return
        }
        self.loginButton.isEnabled = true
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @IBAction func loginActionTapped(_ sender: UIButton) {
        userNameTextField.resignFirstResponder()
            KRProgressHUD.show(withMessage: "Loging in...")
            viewModel.login { result, error in
                KRProgressHUD.dismiss()
                if error == nil
                {
                    if let _ = result?.success, let token = result?.token {
                        self.authToken = token
                        self.performSegue(withIdentifier: "booksListingSegue", sender: self)
                    }
                }
                else
                {
                    Helper.showErrorMessage(title: "Error", description: error!, controller: self)
                }
        }
       
    }
    
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "booksListingSegue" {
            let navController = segue.destination as! UINavigationController
            let targetController = navController.topViewController as! BooksListingController
            targetController.dictionary = ["Authorization": self.authToken]
        }
     }
 
    
  }

extension SignInController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            self.loginActionTapped(UIButton())
        }
        return true
    }
    

}
