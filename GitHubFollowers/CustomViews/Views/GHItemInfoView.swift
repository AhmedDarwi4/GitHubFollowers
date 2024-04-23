//
//  GHItemInfoView.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 02/04/2024.
//

import UIKit

enum IteminfoType{
    case repos,gists,followers,followings
}


class GHItemInfoView: UIView {
    
    let symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .label
        return imageView
    }()
    
    let titleLabel: GHTitleLabel = {
        let label = GHTitleLabel(textAlignment: .left, fontSize: 14)

        return label
    }()
    
    let countLabel: GHTitleLabel = {
        let label = GHTitleLabel(textAlignment: .center, fontSize: 14)
        return label
    }()

    override init(frame:CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo:self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: padding),
            symbolImageView.heightAnchor.constraint(equalToConstant: padding),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor,constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        
        ])
    }
    
    func set(iteminfoType:IteminfoType, withCount count: Int){
        switch iteminfoType{
        case .repos:
            symbolImageView.image     = UIImage(systemName: SFSymbols.repos)
            titleLabel.text           = "Public Repos"
        case .gists:
            symbolImageView.image     = UIImage(systemName: SFSymbols.gists)
            titleLabel.text           = "Public Gists"
        case .followers:
            symbolImageView.image     = UIImage(systemName: SFSymbols.followers)
            titleLabel.text           = "Followers"
        case .followings:
            symbolImageView.image     = UIImage(systemName: SFSymbols.following)
            titleLabel.text           = "Follwings"
        }
        
        countLabel.text = String(count)
    }
    
    
}
