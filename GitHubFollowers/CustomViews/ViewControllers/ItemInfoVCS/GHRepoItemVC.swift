//
//  GHRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 03/04/2024.
//

import UIKit

/// this is the first subclass view controller
class GHRepoItemVC:GHItemInfoVC{
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewOne.set(iteminfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(iteminfoType: .gists, withCount: user.publicGists)
        actionButton.set(backGroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTabGitHubProfile(for: user)
    }
    
    
    
}
