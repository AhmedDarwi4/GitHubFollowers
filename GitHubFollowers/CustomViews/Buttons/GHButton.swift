//
//  GHButton.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 04/03/2024.
//

import UIKit

class GHButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder:NSCoder) {
        fatalError("Unsupported")
    }
    
    
    init(backGroundColor:UIColor,title:String){
        super.init(frame: .zero)
        self.backgroundColor = backGroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backGroundColor:UIColor,title:String){
        self.backgroundColor = backGroundColor
        setTitle(title, for: .normal)
    }

    
    
}
