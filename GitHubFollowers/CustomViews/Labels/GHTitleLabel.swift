//
//  GFTitleLabel.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 11/03/2024.
//

import UIKit

class GHTitleLabel: UILabel {

    override init(frame:CGRect){
        super.init(frame: frame)
        configure()
    }

    required init?(coder:NSCoder) {
        fatalError("Unsupported")
    }
    
    init(textAlignment:NSTextAlignment,fontSize:CGFloat){
        super.init(frame:.zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    private func configure(){
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
