//
//  SLPlayerGameDetailsVC+TableView.swift
//  SnakeAndLadders
//
//  Created by Rajan Maheshwari on 14/07/18.
//  Copyright © 2018 Rajan Maheshwari. All rights reserved.
//

import UIKit

extension SLPlayerGameDetailsVC: UITableViewDataSource {
    
    enum Option: Int {
        case gameDetails, playerDetails
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Option(rawValue: indexPath.row)! {
            
        case .gameDetails:
            let cell:SLGameInfoCell = tableView.dequeueReusableCell()
            cell.noOfLinesTextField.delegate = self
            return cell
            
        case .playerDetails:
            let cell:SLPlayersInfoCell = tableView.dequeueReusableCell()
            cell.playerOneTextField.delegate = self
            cell.playerTwoTextField.delegate = self
            cell.playerThreeTextField.delegate = self
            cell.playerFourTextField.delegate = self
            return cell
        }
    }
    
    
}
