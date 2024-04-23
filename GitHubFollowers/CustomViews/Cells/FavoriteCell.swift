//
//  FavoriteCell.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 09/04/2024.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    let avatarImageView:GHAvatarImageView = {
        let imageView = GHAvatarImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    let usernameLabel:GHTitleLabel = {
        let label = GHTitleLabel(textAlignment: .left, fontSize: 26)
        return label
    }()
    
   static let cellIdentifier = String(describing: FavoriteCell.self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite:Follower){
        usernameLabel.text = favorite.login
        avatarImageView.downloadImage(from: favorite.avatarUrl)
    }
    
   private func configure(){
       contentView.addSubview(avatarImageView)
       contentView.addSubview(usernameLabel)
       accessoryType = .disclosureIndicator
       
       let padding: CGFloat = 12
       NSLayoutConstraint.activate([
        avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
        avatarImageView.heightAnchor.constraint(equalToConstant: 60),
        avatarImageView.widthAnchor.constraint(equalToConstant: 60),
        
        
        usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
        usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
        usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
        usernameLabel.heightAnchor.constraint(equalToConstant: 40)
       
       ])
       
    }
    
}
