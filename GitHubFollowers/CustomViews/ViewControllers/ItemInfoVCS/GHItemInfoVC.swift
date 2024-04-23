//
//  GHItemInfoVC.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 02/04/2024.
//

import UIKit

/// This is the item info super class
class GHItemInfoVC: UIViewController {

    let stackView: UIStackView = {
        let stackView           = UIStackView()
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let itemInfoViewOne: GHItemInfoView = {
        let view = GHItemInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let itemInfoViewTwo: GHItemInfoView = {
        let view = GHItemInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let actionButton: GHButton = {
        let button = GHButton()
        return button
    }()
    
    var user:User!
    weak var delegate:UserInfoVCDelegate!
    
    init(user:User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureActionButton()
        layoutUI()
    }
    
   private func configureBackgroundView(){
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureActionButton(){
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped(){
        
    }
    
    
   private func layoutUI(){
        view.addSubview(stackView)
       stackView.addArrangedSubview(itemInfoViewOne)
       stackView.addArrangedSubview(itemInfoViewTwo)
       view.addSubview(actionButton)
       let padding: CGFloat = 20
       NSLayoutConstraint.activate([
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        stackView.heightAnchor.constraint(equalToConstant: 50),
        
        actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
        actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
        actionButton.heightAnchor.constraint(equalToConstant: 44)
       
       ])
        
    }


}
