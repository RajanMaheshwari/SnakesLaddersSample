//
//  SLPlayVC.swift
//  SnakeAndLadders
//
//  Created by Rajan Maheshwari on 13/07/18.
//  Copyright © 2018 Rajan Maheshwari. All rights reserved.
//

import UIKit

class SLPlayVC: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var diceImageView: UIImageView!
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var multiplierConstraint: NSLayoutConstraint!
    @IBOutlet weak var boardCollectionView: UICollectionView!
    
    var ratio:CGFloat = 0.0
    var blocks = Array<Block>()
    let totalRows = 7
    
    let playerOne = Player()
    let playerTwo = Player()

    var stairs = [(from:Int, to:Int)]()
    var snakes = [(from:Int, to:Int)]()
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.diceImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(diceRoll)))
    }

    //MARK:- Private Methods
    private func setup() {
        self.initiateGameSetup()
        self.boardCollectionView.register(SLBlockCell.self)
        if Utilities.DeviceType.iPhoneX {
            let newConstraint = self.multiplierConstraint.constraintWithMultiplier(0.4926108374)
            newConstraint.isActive = true
            self.view.removeConstraint(self.multiplierConstraint)
            self.view.addConstraint(newConstraint)
            self.view.layoutIfNeeded()
        }
        self.makeData()
        self.boardCollectionView.reloadData()
    }
    
    private func initiateGameSetup() {
        playerOne.name = "Player 1"
        playerTwo.name = "Player 2"
        playerOne.score = 0
        playerTwo.score = 0
        playerOne.block = nil
        playerTwo.block = nil
        playerOne.isMyChance = true
        playerTwo.isMyChance = false
        self.statusLabel.text = "\(playerOne.name) Turn"
        self.updateScore()
        self.playerOneLabel.text = playerOne.name
        self.playerTwoLabel.text = playerTwo.name
        
        self.boardCollectionView.reloadData()
    }
    
    //Making the board numbers
    private func makeData() {
        for i in (1...totalRows).reversed() {
            let maxRowNumber = totalRows * i
            if i % 2 == 0 {
                //even rows
                for index in stride(from: maxRowNumber, to: (maxRowNumber - totalRows), by: -1) {
                    let block = Block()
                    block.value = index
                    block.position = blocks.count
                    blocks.append(block)
                }

            } else {
                //odd rows
                for index in stride(from: (maxRowNumber - totalRows + 1), to: maxRowNumber + 1, by: 1) {
                    let block = Block()
                    block.value = index
                    block.position = blocks.count
                    blocks.append(block)
                }
            }
        }
        addPowers()
    }
    
    //Adding snake and ladder powers
    private func addPowers() {
        stairs.append((2,11))
        stairs.append((8,19))
        stairs.append((22,33))
        stairs.append((35,47))

        snakes.append((48,10))
        snakes.append((36,23))
        snakes.append((28,15))
        snakes.append((14,3))

        for stair in stairs {
            blocks.forEach { (block:Block) in
                if block.value == stair.from {
                    block.stairTo = stair.to
                }
            }
        }
        
        for snake in snakes {
            blocks.forEach { (block:Block) in
                if block.value == snake.from {
                    block.snakeTo = snake.to
                }
            }
        }
    }
    
    func goToWinner(winner:String) {
        let winnerVC = SLWinnerVC.instantiate(fromAppStoryboard: .Play)
        winnerVC.winner = winner
        winnerVC.delegate = self
        self.navigationController?.pushViewController(winnerVC, animated: true)
    }
    
    private func updateScore() {
        self.playerOneScoreLabel.text = "\(self.playerOne.score)"
        self.playerTwoScoreLabel.text = "\(self.playerTwo.score)"
        
        if self.playerOne.score != 0 {
            if let block1 = blocks.filter({$0.value == playerOne.score}).first {
            self.playerOne.block = block1
            }
        }
        
        if self.playerTwo.score != 0 {
            if let block2 = blocks.filter({$0.value == self.playerTwo.score}).first {
                self.playerTwo.block = block2
            }
        }
        
        self.boardCollectionView.reloadData()
        
        if playerOne.score == 49 {
            self.statusLabel.text = "\(playerOne.name) is WINNER"
            self.goToWinner(winner: playerOne.name)
            return
        }
        if playerTwo.score == 49 {
            self.statusLabel.text = "\(playerTwo.name) is WINNER"
            self.goToWinner(winner: playerTwo.name)
        }
    }
    
    func calculateScore(value:Int) -> Int {
        if let block = blocks.filter({$0.value == value}).first {
            if block.stairTo != 0  {
                return block.stairTo
            }
            if block.snakeTo != 0  {
                return block.snakeTo
            }
        }
        return value
    }
    
    //Dice Rolling Action
    @objc func diceRoll() {
        let diceRoll = Int(arc4random_uniform(6)) + 1
        diceImageView.image = UIImage(named: "Dice\(diceRoll)")
        if playerOne.isMyChance {
            self.playerOne.score += diceRoll
            if playerOne.score > 49 {
                playerOne.score -= diceRoll
                self.statusLabel.text = "\(playerOne.name) Can't move"
            }
            self.playerOne.score = calculateScore(value: self.playerOne.score)
            if diceRoll != 6 {
                playerTwo.isMyChance = true
                playerOne.isMyChance = false
                self.statusLabel.text = "\(playerTwo.name) Turn"
            }
        } else {
            self.playerTwo.score += diceRoll
            if playerTwo.score > 49 {
                playerTwo.score -= diceRoll
                self.statusLabel.text = "\(playerTwo.name) Can't move"
            }
            self.playerTwo.score = calculateScore(value: self.playerTwo.score)
            if diceRoll != 6 {
                playerOne.isMyChance = true
                playerTwo.isMyChance = false
                self.statusLabel.text = "\(playerOne.name) Turn"
            }
        }
        self.updateScore()
    }

}

extension SLPlayVC:RefreshDelegate {
    func refresh() {
        self.initiateGameSetup()
    }
}
