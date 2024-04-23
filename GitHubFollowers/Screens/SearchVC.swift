//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 03/03/2024.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gh-logo")
        return imageView
    }()
    
    let usernameTextField: GHTextField = {
        let textField = GHTextField()
        return textField
    }()
    
    let getFollowersButton:GHButton = {
        var button = GHButton()
        button = GHButton(backGroundColor: .systemGreen, title: "Get Followers")
        return button
    }()
    
    var isUsernameEntered:Bool{
        
        return !usernameTextField.text!.isEmpty
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        configureLogoImageView()
        configureGHTextField()
        configureGetFollowersButton()
        createDismissKeyboardTabGesture()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // navigationItem.title = .none
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
   
    // MARK: - KeyboardDismiss
    
    func createDismissKeyboardTabGesture(){
        let tap  = UITapGestureRecognizer(target: self.view, action:#selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowerListVc(){
        guard isUsernameEntered else{
            presentGHAlertOnMainThread(title: "Empty username", message: "Please enter a username. we need to know who to look for 👀", buttonTitle: "OK")
            
            print("No username")
            return
        }
        let followersListVC = FollowersListVC()
        followersListVC.userName = usernameTextField.text
        followersListVC.title = usernameTextField.text
        navigationController?.pushViewController(followersListVC, animated: true)
    }
    
    // MARK: - Configure
    
    func configureLogoImageView(){
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    func configureGHTextField(){
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            usernameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            usernameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureGetFollowersButton(){
        view.addSubview(getFollowersButton)
        getFollowersButton.addTarget(self, action: #selector(pushFollowerListVc), for: .touchUpInside)
        NSLayoutConstraint.activate([
        getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
        getFollowersButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
        getFollowersButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
        getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        
        ])
    }
    
    
    
}

extension SearchVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       pushFollowerListVc()
        return true
    }
}
