//
//  SLPlayerGameDetailsVC+TextField.swift
//  SnakeAndLadders
//
//  Created by Rajan Maheshwari on 14/07/18.
//  Copyright © 2018 Rajan Maheshwari. All rights reserved.
//

import UIKit

extension SLPlayerGameDetailsVC: UITextFieldDelegate {
    
    enum TextOptions:Int {
        case noOfLines = 1, playerOne, playerTwo, playerThree, playerFour
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch TextOptions(rawValue: textField.tag)! {
            
        case .noOfLines:
            if let noOfLines = Int(textField.text!) {
                self.noOfLines = noOfLines
            }
            
        case .playerOne, .playerTwo, .playerThree, .playerFour:
            if !textField.text!.isEmpty {
                players[textField.tag - 2].name = textField.text!
            }
        }
    }
    
}
