//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 18/03/2024.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let cellIdentifier = "FollowerCell"
    
    let padding: CGFloat = 8
    
    let avatarImageView:GHAvatarImageView = {
        let imageView = GHAvatarImageView(frame: .zero)
        return imageView
    }()
    
    let usernameLabel: GHTitleLabel = {
        let label = GHTitleLabel(textAlignment: .center, fontSize: 16)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    func set(follower:Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    
    private func configure(){
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
       
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
           
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}


