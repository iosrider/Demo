//
//  AddNewBookController.swift
//  HsbcTest
//
//  Created by Ankit Vyas on 12/08/19.
//  Copyright © 2019 Ankit Vyas. All rights reserved.
//

import UIKit

class AddNewBookController: UIViewController {
    @IBOutlet weak var bgView: UIView!
    private var viewModel = AddBookViewModel(bookTitle: "",
                                             bookAuthor: "",
                                             bookPublisher: "",
                                             bookisbn: "32132dsfs",
                                             bookImage: "https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/evolving_google_identity_share.jpg")
    var headers = [String: String]()
    @IBOutlet weak var bookTitleTextField: BindingTextField! {
        didSet {
            bookTitleTextField.bind { self.viewModel.bookTitle = $0 }
        }
    }
    @IBOutlet weak var bookAuthorTextField: BindingTextField! {
        didSet {
            bookAuthorTextField.bind { self.viewModel.bookAuthor = $0 }
        }
    }
    
    @IBOutlet weak var bookPublisherTextField: BindingTextField! {
        didSet {
            bookPublisherTextField.bind { self.viewModel.bookPublisher = $0 }
        }
    }
    
    @IBOutlet weak var bookisbnTextField: BindingTextField! {
        didSet {
            bookisbnTextField.bind { self.viewModel.bookisbn = $0 }
        }
    }
    
    @IBOutlet weak var bookImageTextField: BindingTextField! {
        didSet {
            bookImageTextField.bind { self.viewModel.bookImage = $0 }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.addAllCornerRadious(bgView, radious: 10.0)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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

    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func createButtonTapped(_ sender: UIButton) {
        viewModel.addBook(headers: headers) { result, error in
            if error == nil {
                if let response = result {
                    if response.success {
                        self.cancelButtonTapped(sender)
                    }
                }
            } else {
                print(error!)
            }
        }
    }

}


extension AddNewBookController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case bookTitleTextField:
            bookAuthorTextField.becomeFirstResponder()
        case bookAuthorTextField:
            bookPublisherTextField.becomeFirstResponder()
        case bookPublisherTextField:
            textField.resignFirstResponder()
            self.createButtonTapped(UIButton())
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
