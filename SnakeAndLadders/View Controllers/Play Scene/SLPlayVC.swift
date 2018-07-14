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
    @IBOutlet weak var playerFourScoreLabel: UILabel!
    @IBOutlet weak var playerFourLabel: UILabel!
    @IBOutlet weak var playerThreeScoreLabel: UILabel!
    @IBOutlet weak var playerThreeLabel: UILabel!
    @IBOutlet weak var boardCollectionView: UICollectionView!
    
    var ratio:CGFloat = 0.0
    var blocks = Array<Block>()
    var players = Array<Player>()

    let blocksPerRow = 7
    var totalRows = 0
    
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
        
        self.playerOneLabel.text = ""
        self.playerTwoLabel.text = ""
        self.playerThreeLabel.text = ""
        self.playerFourLabel.text = ""
        
        for (index,player) in players.enumerated() {
            player.block = nil
            player.score = 0
            player.isMyChance = false
            switch index {
                
            case 0:
                self.playerOneLabel.text = player.name
                player.isMyChance = true

            case 1:
                self.playerTwoLabel.text = player.name
                
            case 2:
                self.playerThreeLabel.text = player.name
                
            case 3:
                self.playerFourLabel.text = player.name
                
            default:
                return
            }
            self.statusLabel.text = "\(playerOne.name) Turn"
        }
        self.updateScore()
        self.boardCollectionView.reloadData()
    }
    
    //Making the board numbers
    private func makeData() {
        for i in (1...totalRows).reversed() {
            let maxRowNumber = blocksPerRow * i
            if i % 2 == 0 {
                //even rows
                for index in stride(from: maxRowNumber, to: (maxRowNumber - blocksPerRow), by: -1) {
                    let block = Block()
                    block.value = index
                    block.position = blocks.count
                    blocks.append(block)
                }

            } else {
                //odd rows
                for index in stride(from: (maxRowNumber - blocksPerRow + 1), to: maxRowNumber + 1, by: 1) {
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
        stairs.append((34,47))

        snakes.append((48,10))
        snakes.append((36,23))
        snakes.append((27,15))
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
        
        for (index,player) in players.enumerated() {
            //Check if anyone has won
            if player.score == totalRows * blocksPerRow {
                self.statusLabel.text = "\(player.name) is WINNER"
                self.goToWinner(winner: player.name)
                return
            }
            
            //Assigning block to players
            if player.score != 0 {
                if let block = blocks.filter({$0.value == player.score}).first {
                    player.block = block
                }
            }
            
            switch index {
            case 0:
                self.playerOneScoreLabel.text = "\(player.score)"
                
            case 1:
                self.playerTwoScoreLabel.text = "\(player.score)"
                
            case 2:
                self.playerThreeScoreLabel.text = "\(player.score)"

            case 3:
                self.playerFourScoreLabel.text = "\(player.score)"

            default:
                return
            }
        }
        
//        self.playerOneScoreLabel.text = "\(self.playerOne.score)"
//        self.playerTwoScoreLabel.text = "\(self.playerTwo.score)"
        
//        if self.playerOne.score != 0 {
//            if let block1 = blocks.filter({$0.value == playerOne.score}).first {
//            self.playerOne.block = block1
//            }
//        }
//
//        if self.playerTwo.score != 0 {
//            if let block2 = blocks.filter({$0.value == self.playerTwo.score}).first {
//                self.playerTwo.block = block2
//            }
//        }
        
        self.boardCollectionView.reloadData()
        
//        if playerOne.score == totalRows * blocksPerRow {
//            self.statusLabel.text = "\(playerOne.name) is WINNER"
//            self.goToWinner(winner: playerOne.name)
//            return
//        }
//        if playerTwo.score == totalRows * blocksPerRow {
//            self.statusLabel.text = "\(playerTwo.name) is WINNER"
//            self.goToWinner(winner: playerTwo.name)
//        }
    }
    
    func calculateScore(value:Int) -> Int {
        if let block = blocks.filter({$0.value == value}).first {
            if block.stairTo != 0  {
                SoundManager.shared.playSound(soundName: "ladder")
                return block.stairTo
            }
            if block.snakeTo != 0  {
                SoundManager.shared.playSound(soundName: "snakeBite")
                return block.snakeTo
            }
        }
        return value
    }
    
    //Dice Rolling Action
    @objc func diceRoll() {
        SoundManager.shared.playSound(soundName: "move")

        let diceRoll = Int(arc4random_uniform(6)) + 1
        diceImageView.image = UIImage(named: "Dice\(diceRoll)")
        
        for (index,player) in players.enumerated() {
            if player.isMyChance {
                player.score += diceRoll
                if player.score > totalRows * blocksPerRow {
                    player.score -= diceRoll
                    self.statusLabel.text = "\(player.name) Can't move"
                }
                player.score = calculateScore(value: player.score)
                if diceRoll != 6 {
                    
                    //Change chance
                    player.isMyChance = false
                    if index < players.count - 1 {
                        players[index+1].isMyChance = true
                        self.statusLabel.text = "\(players[index+1].name) Turn"
                    } else {
                        //It means that it was last player chance. Now moving the pointer back to first player
                        players[0].isMyChance = true
                        self.statusLabel.text = "\(players[0].name) Turn"
                    }
                    break
                }
            }
        }
        
        
//        if playerOne.isMyChance {
//            self.playerOne.score += diceRoll
//            if playerOne.score > totalRows * blocksPerRow {
//                playerOne.score -= diceRoll
//                self.statusLabel.text = "\(playerOne.name) Can't move"
//            }
//            self.playerOne.score = calculateScore(value: self.playerOne.score)
//            if diceRoll != 6 {
//                playerTwo.isMyChance = true
//                playerOne.isMyChance = false
//                self.statusLabel.text = "\(playerTwo.name) Turn"
//            }
//        } else {
//            self.playerTwo.score += diceRoll
//            if playerTwo.score > totalRows * blocksPerRow {
//                playerTwo.score -= diceRoll
//                self.statusLabel.text = "\(playerTwo.name) Can't move"
//            }
//            self.playerTwo.score = calculateScore(value: self.playerTwo.score)
//            if diceRoll != 6 {
//                playerOne.isMyChance = true
//                playerTwo.isMyChance = false
//                self.statusLabel.text = "\(playerOne.name) Turn"
//            }
//        }
        self.updateScore()
    }
    
}

extension SLPlayVC:RefreshDelegate {
    func refresh() {
        self.initiateGameSetup()
    }
}
