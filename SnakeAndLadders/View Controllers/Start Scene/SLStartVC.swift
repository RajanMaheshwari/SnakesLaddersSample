//
//  SLStartVC.swift
//  SnakeAndLadders
//
//  Created by Rajan Maheshwari on 13/07/18.
//  Copyright © 2018 Rajan Maheshwari. All rights reserved.
//

import UIKit

class SLStartVC: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    //MARK:- Private Methods
    private func setup() {
        self.scaleInOut()
    }
    
    private func scaleInOut() {
        UIView.animate(withDuration: 1.0, delay: 0, options: .allowUserInteraction, animations: {
            self.playButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (_) in
            UIView.animate(withDuration: 1.0, delay: 0, options: .allowUserInteraction, animations: {
                self.playButton.transform = CGAffineTransform.identity
            }) { (_) in
                self.scaleInOut()
            }
        }
    }
    
    //MARK:- IBActions
    @IBAction func playButtonAction(_ sender: Any) {
        let playVC = SLPlayVC.instantiate(fromAppStoryboard: .Play)
        self.navigationController?.pushViewController(playVC, animated: true)
    }
    
}
