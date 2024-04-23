//
//  GHFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 03/04/2024.
//

import UIKit

/// This is the second subclass view controller
class GHFollowerItemVC:GHItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(iteminfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(iteminfoType: .followings, withCount: user.following)
        actionButton.set(backGroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
    
    
}
