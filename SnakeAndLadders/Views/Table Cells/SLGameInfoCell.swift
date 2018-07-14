//
//  SLGameInfoCell.swift
//  SnakeAndLadders
//
//  Created by Rajan Maheshwari on 14/07/18.
//  Copyright © 2018 Rajan Maheshwari. All rights reserved.
//

import UIKit

class SLGameInfoCell: UITableViewCell {

    @IBOutlet weak var noOfLinesTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SLGameInfoCell: NibLoadableView, ReusableView {
}
