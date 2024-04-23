//
//  GHBodyLabel.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 11/03/2024.
//

import UIKit

class GHBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder:NSCoder) {
        fatalError("Unsupported")
    }
    
    init(textAlignment:NSTextAlignment){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
   private func configure(){
       textColor = .secondaryLabel
       font = UIFont.preferredFont(forTextStyle: .body)
       adjustsFontSizeToFitWidth = true
       minimumScaleFactor = 0.75
       translatesAutoresizingMaskIntoConstraints = false
       
   }

}

