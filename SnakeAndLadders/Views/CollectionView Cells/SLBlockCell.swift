//
//  SLBlockCell.swift
//  SnakeAndLadders
//
//  Created by Rajan Maheshwari on 13/07/18.
//  Copyright © 2018 Rajan Maheshwari. All rights reserved.
//

import UIKit

class SLBlockCell: UICollectionViewCell {

    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var playerTwoTokenView: UIView!
    @IBOutlet weak var playerOneTokenView: UIView!
    @IBOutlet weak var snakeLadderImageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var playerFourTokenView: UIView!
    
    @IBOutlet weak var playerThreeTokenView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.playerOneTokenView.isHidden = true
        self.playerOneTokenView.backgroundColor = UIColor.red
        self.playerOneTokenView.layer.cornerRadius = self.playerOneTokenView.frame.size.width/2
        
        self.playerTwoTokenView.isHidden = true
        self.playerTwoTokenView.backgroundColor = UIColor.blue
        self.playerTwoTokenView.layer.cornerRadius = self.playerTwoTokenView.frame.size.width/2
        
        self.playerThreeTokenView.isHidden = true
        self.playerThreeTokenView.backgroundColor = UIColor.green
        self.playerThreeTokenView.layer.cornerRadius = self.playerThreeTokenView.frame.size.width/2
        
        self.playerFourTokenView.isHidden = true
        self.playerFourTokenView.backgroundColor = UIColor.yellow
        self.playerFourTokenView.layer.cornerRadius = self.playerFourTokenView.frame.size.width/2
    }
    
    func setData(block:Block) {
        self.playerOneTokenView.isHidden = true
        self.playerTwoTokenView.isHidden = true
        self.playerThreeTokenView.isHidden = true
        self.playerFourTokenView.isHidden = true

        self.valueLabel.text = "\(block.value)"
        snakeLadderImageView.image = nil
        powerLabel.text = ""
        if block.snakeTo != 0 {
            snakeLadderImageView.image = #imageLiteral(resourceName: "snake")
            powerLabel.text = "\(block.snakeTo)"
        }
        if block.stairTo != 0 {
            snakeLadderImageView.image = #imageLiteral(resourceName: "ladder")
            powerLabel.text = "\(block.stairTo)"
        }
    }
    
    func updateToken(indexPath:IndexPath, players:[Player]) {
        for (index,player) in players.enumerated() {
            if let block = player.block, block.position == indexPath.row {
                switch index {
                case 0:
                    self.playerOneTokenView.isHidden = false
                    self.playerTwoTokenView.isHidden = true
                    self.playerThreeTokenView.isHidden = true
                    self.playerFourTokenView.isHidden = true
                    
                case 1:
                    self.playerOneTokenView.isHidden = true
                    self.playerTwoTokenView.isHidden = false
                    self.playerThreeTokenView.isHidden = true
                    self.playerFourTokenView.isHidden = true
                    
                case 2:
                    self.playerOneTokenView.isHidden = true
                    self.playerTwoTokenView.isHidden = true
                    self.playerThreeTokenView.isHidden = false
                    self.playerFourTokenView.isHidden = true
                    
                case 3:
                    self.playerOneTokenView.isHidden = true
                    self.playerTwoTokenView.isHidden = true
                    self.playerThreeTokenView.isHidden = true
                    self.playerFourTokenView.isHidden = false
                    
                default:
                    return
                }
                
            }
        }
        
//
//        if let block1 = playerOne.block, block1.position == indexPath.row {
//            cell.playerOneTokenView.isHidden = false
//            cell.playerTwoTokenView.isHidden = true
//
//        }
//
//        if let block2 = playerTwo.block, block2.position == indexPath.row {
//            cell.playerTwoTokenView.isHidden = false
//            cell.playerOneTokenView.isHidden = true
//        }
    }

}

extension SLBlockCell: ReusableView, NibLoadableView {
}
