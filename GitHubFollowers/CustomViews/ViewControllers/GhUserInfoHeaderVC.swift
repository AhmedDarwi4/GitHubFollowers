//
//  GhUserInfoHeaderVC.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 29/03/2024.
//

import UIKit

class GhUserInfoHeaderVC: UIViewController {
    
    let avatarImageView: GHAvatarImageView = {
        let imageView = GHAvatarImageView(frame: .zero)
        return imageView
    }()
    
    let usernameLabel: GHTitleLabel = {
        let label = GHTitleLabel(textAlignment: .left, fontSize: 34)
        return label
    }()
    
    let nameLabel: GHSecondaryTitleLabel = {
        let label = GHSecondaryTitleLabel(fontSize: 18)
        return label
    }()
    
    let locationImageView: UIImageView = {
        let imageView       = UIImageView()
        imageView.image     = UIImage(systemName: SFSymbols.location)
        imageView.tintColor = .secondaryLabel
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    let locationLabel : GHSecondaryTitleLabel = {
        let label = GHSecondaryTitleLabel(fontSize: 18)
        return label
    }()
    
    let bioLabel: GHBodyLabel = {
        let label = GHBodyLabel(textAlignment: .left)
        label.numberOfLines = 3
        return label
    }()
    
    var user:User!
    
    init(user:User!){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
     required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
    }
    
    
    func configureUIElements(){
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameLabel.text  = user.login
        nameLabel.text      = user.name ?? ""
        locationLabel.text  = user.location ?? "No Location"
        bioLabel.text       = user.bio ?? ""
        
    }
    
   func addSubviews(){
       view.addSubview(avatarImageView)
       view.addSubview(usernameLabel)
       view.addSubview(nameLabel)
       view.addSubview(locationImageView)
       view.addSubview(locationLabel)
       view.addSubview(bioLabel)
    }
    
    func layoutUI(){
        
        let viewPadding: CGFloat              = 20
        let textImagePadding: CGFloat         = 12
        let avatarImageViewWidth: CGFloat     = 90
        let locationimageViewWidth: CGFloat   = 20
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: viewPadding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageViewWidth),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageViewWidth),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),

            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: locationimageViewWidth),
            locationImageView.heightAnchor.constraint(equalToConstant: locationimageViewWidth),

            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor,constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewPadding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),

            bioLabel.topAnchor.constraint(equalTo:avatarImageView.bottomAnchor , constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
            
            
            
            
            
            
        ])
        
        
    }
    

}
