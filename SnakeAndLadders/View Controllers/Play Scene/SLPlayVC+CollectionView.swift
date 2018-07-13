//
//  SLPlayVC+CollectionView.swift
//  SnakeAndLadders
//
//  Created by Rajan Maheshwari on 13/07/18.
//  Copyright © 2018 Rajan Maheshwari. All rights reserved.
//

import UIKit

extension SLPlayVC : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blocks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:SLBlockCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setData(block: blocks[indexPath.row])
        if let block1 = playerOne.block, block1.position == indexPath.row {
            cell.playerOneTokenView.isHidden = false
            cell.playerTwoTokenView.isHidden = true

        }
        
        if let block2 = playerTwo.block, block2.position == indexPath.row {
            cell.playerTwoTokenView.isHidden = false
            cell.playerOneTokenView.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 9, 0, 9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.125
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
