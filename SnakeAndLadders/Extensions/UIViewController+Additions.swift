//
//  UIViewController+Additions.swift
//  SnakeAndLadders
//
//  Created by Rajan Maheshwari on 13/07/18.
//  Copyright © 2018 Rajan Maheshwari. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Not using static as it wont be possible to override to provide custom storyboardID then
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func showAlert(title:String, message:String, button:String, _ completionHandler:(()->())?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: button, style: .default) { (action) in
            completionHandler?()
        }
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
}
