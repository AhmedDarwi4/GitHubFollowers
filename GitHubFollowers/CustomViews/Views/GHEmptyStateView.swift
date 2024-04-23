//
//  GHEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 25/03/2024.
//

import UIKit

class GHEmptyStateView: UIView {
    
    let messageLabel: GHTitleLabel = {
        let label = GHTitleLabel(textAlignment: .center, fontSize: 28)
        label.numberOfLines = 3
        label.textColor = .secondaryLabel
        return label
    }()
    
    let logoImageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "empty-state-logo")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
       
    }
    
    required init(coder:NSCoder) {
        fatalError("unsupported")
    }
    
    init(message:String){
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    
    private func configure(){
        addSubview(messageLabel)
        addSubview(logoImageView)
       
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
       
        
        NSLayoutConstraint.activate([
            
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 140)
            
            
        ])
    }
    
    
}
