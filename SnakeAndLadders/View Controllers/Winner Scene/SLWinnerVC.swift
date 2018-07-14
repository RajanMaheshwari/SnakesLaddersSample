//
//  SLWinnerVC.swift
//  SnakeAndLadders
//
//  Created by Rajan Maheshwari on 14/07/18.
//  Copyright © 2018 Rajan Maheshwari. All rights reserved.
//

import UIKit

protocol RefreshDelegate:class {
    func refresh()
}

class SLWinnerVC: UIViewController {

    @IBOutlet weak var congoLabel: UILabel!
    var winner = ""
    weak var delegate:RefreshDelegate?
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.congoLabel.text = "Congratulations \(winner)"
        SoundManager.shared.playSound(soundName: "winner")

    }

    //MARK:- IBActions
    @IBAction func playAgainAction(_ sender: Any) {
        if let delegate = delegate {
            delegate.refresh()
        }
        self.navigationController?.popViewController(animated: true)
    }


}
