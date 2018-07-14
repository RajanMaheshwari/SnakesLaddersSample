//
//  SLPlayerGameDetailsVC.swift
//  SnakeAndLadders
//
//  Created by Rajan Maheshwari on 14/07/18.
//  Copyright © 2018 Rajan Maheshwari. All rights reserved.
//

import UIKit

class SLPlayerGameDetailsVC: UIViewController {

    @IBOutlet weak var informationTableView: UITableView!
    
    var players = Array<Player>()
    var noOfLines = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        //Add four dummy player records
        players.append(Player())
        players.append(Player())
        players.append(Player())
        players.append(Player())

        self.informationTableView.alwaysBounceVertical = false
        self.informationTableView.register(SLGameInfoCell.self)
        self.informationTableView.register(SLPlayersInfoCell.self)
    }
    
    
    
    func validate() -> Bool {
        self.dismissKeyboard()
        if noOfLines > 7 || noOfLines <= 2 {
            self.showAlert(title: "Error", message: "Invalid number of board lines", button: "Ok", nil)
            return false
        }
        if players.filter({!$0.name.isEmpty}).count < 2 {
            self.showAlert(title: "Error", message: "Atleast 2 players are required to play the game", button: "Ok", nil)
            return false
        }
        return true
    }

    @IBAction func playButtonAction(_ sender: Any) {
        if validate() {
            let playVC = SLPlayVC.instantiate(fromAppStoryboard: .Play)
            playVC.totalRows = noOfLines
            let activePlayers = players.filter({!$0.name.isEmpty})
            playVC.players = activePlayers
            self.navigationController?.pushViewController(playVC, animated: true)
        }
    }
}
