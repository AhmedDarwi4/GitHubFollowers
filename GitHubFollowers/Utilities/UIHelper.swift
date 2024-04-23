//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 22/03/2024.
//

import UIKit

struct UIHelper {
    static func createThreeColumnFlowLayout(in view:UIView)->UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpaces: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpaces * 2)
        let itemWidth = availableWidth / 3
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
}


