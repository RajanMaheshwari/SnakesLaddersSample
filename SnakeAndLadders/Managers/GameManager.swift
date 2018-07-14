//
//  GameManager.swift
//  SnakeAndLadders
//
//  Created by Rajan Maheshwari on 14/07/18.
//  Copyright © 2018 Rajan Maheshwari. All rights reserved.
//

import Foundation

class GameManager {
    
    //Adding powers to the game w.r.t number of lines on the board
    class func addPowers(noOfLines:Int) -> (stairs:[(Int,Int)], snakes:[(Int,Int)])? {
        var stairs = [(from:Int, to:Int)]()
        var snakes = [(from:Int, to:Int)]()
        
        switch noOfLines {
            
        case 3:
            stairs.append((2,11))
            stairs.append((8,19))
            
            snakes.append((20,5))
            snakes.append((14,3))
            
            return(stairs, snakes)
            
        case 4:
            stairs.append((2,11))
            stairs.append((8,19))
            
            snakes.append((27,15))
            snakes.append((14,3))
            
            return(stairs, snakes)
            
        case 5:
            stairs.append((2,11))
            stairs.append((8,19))
            stairs.append((22,33))
            
            snakes.append((34,10))
            snakes.append((27,15))
            snakes.append((14,3))
            
            return(stairs, snakes)
            
        case 6:
            stairs.append((2,11))
            stairs.append((8,19))
            stairs.append((22,33))
            stairs.append((34,40))
            
            snakes.append((48,10))
            snakes.append((36,23))
            snakes.append((27,15))
            snakes.append((14,3))
            
            return(stairs, snakes)
            
        case 7:
            stairs.append((2,11))
            stairs.append((8,19))
            stairs.append((22,33))
            stairs.append((34,47))
            
            snakes.append((48,10))
            snakes.append((36,23))
            snakes.append((27,15))
            snakes.append((14,3))
            
            return(stairs, snakes)
            
        default:
            return nil
        }
    }
    
    //Calculate the dice + snake/ladders logic
    class func calculateScore(value:Int, blocks:[Block]) -> Int {
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
}
