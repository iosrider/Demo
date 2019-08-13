//
//  Helper.swift
//  HsbcTest
//
//  Created by Ankit Vyas on 12/08/19.
//  Copyright © 2019 Ankit Vyas. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
   class func addAllCornerRadious(_ view: UIView, radious: CGFloat) {
        view.layer.cornerRadius = radious
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        // border
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 7.0
        view.layer.shadowRadius = 4.0
    }
    
    class func showErrorMessage(title: String, description: String, controller: UIViewController) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        action.accessibilityLabel = "Okay"
        alert.addAction(action)
        
        controller.present(alert, animated: true, completion: nil)
    }
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
