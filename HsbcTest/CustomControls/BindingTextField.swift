//
//  BindingTextField.swift
//  HsbcTest
//
//  Created by Ankit Vyas on 11/08/19.
//  Copyright © 2019 Ankit Vyas. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

class BindingTextField: UITextField {
    
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    var textChangeClosure: (String) -> () = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func bind(callback: @escaping (String) -> ()) {
        self.textChangeClosure = callback
    }
    
    private func commonInit() {
        self.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        if let text = textField.text {
            self.textChangeClosure(text)
        }
    }
}
