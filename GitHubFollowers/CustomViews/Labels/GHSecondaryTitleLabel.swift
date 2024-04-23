//
//  GHSecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 29/03/2024.
//

import UIKit

class GHSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize:CGFloat){
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize:fontSize, weight: .medium)
        configure()
    }
    
   func configure(){

       textColor = .secondaryLabel
       adjustsFontSizeToFitWidth = true
       lineBreakMode = .byTruncatingTail
       minimumScaleFactor = 0.90
       translatesAutoresizingMaskIntoConstraints = false
       
    }
    
}
