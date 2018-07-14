//
//  SLPlayersInfoCell.swift
//  SnakeAndLadders
//
//  Created by Rajan Maheshwari on 14/07/18.
//  Copyright © 2018 Rajan Maheshwari. All rights reserved.
//

import UIKit

class SLPlayersInfoCell: UITableViewCell {

    @IBOutlet weak var playerFourTextField: UITextField!
    @IBOutlet weak var playerThreeTextField: UITextField!
    @IBOutlet weak var playerTwoTextField: UITextField!
    @IBOutlet weak var playerOneTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SLPlayersInfoCell: NibLoadableView, ReusableView {
}
