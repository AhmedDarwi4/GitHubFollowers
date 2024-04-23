//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 28/03/2024.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject{
    func didTabGitHubProfile(for user:User)
    func didTapGetFollowers(for user:User)
}

class UserInfoVC: UIViewController {
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let itemViewOne: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let itemViewTwo: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dateLabel:GHBodyLabel = {
        let label = GHBodyLabel(textAlignment: .center)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var username:String?
    var itemViews: [UIView] = []
    weak var delegate:FollowerVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        getUserinfo()
        layoutUI()
     
    }
    
    func configureVC(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserinfo(){
        NetworkManager.shared.getUserInfo(for: username ?? "") {[weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    print("user-->\(user)")
                    self.configureUIElements(with: user)
                }
             
            case .failure(let failure):
                self.presentGHAlertOnMainThread(title: "Something Went Wrong", message: failure.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user:User){
        
        let repoItemVC            = GHRepoItemVC(user: user)
        repoItemVC.delegate       = self
        
        let followerItemVC        = GHFollowerItemVC(user: user)
        followerItemVC.delegate   = self
        
        let userInfoHeaderVC      = GhUserInfoHeaderVC(user: user)
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.add(childVC: userInfoHeaderVC, to: self.headerView)
        self.dateLabel.text = "GitHub Since \(user.createdAt.convertToDisplayFormat())"
    }
    
    
    func add(childVC:UIViewController,to containerView:UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func layoutUI(){
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView,itemViewOne,itemViewTwo,dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding)
            ])
            
        }
      
   
   
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    
   @objc func dismissVC(){
        dismiss(animated: true)
    }

}


extension UserInfoVC:UserInfoVCDelegate{
    func didTabGitHubProfile(for user: User) {
        // Show safari view controller
        guard let url = URL(string:user.htmlUrl) else {
            presentGHAlertOnMainThread(title: "Invalid URl", message: "The url attatched to this user is invalid", buttonTitle: "OK")
            return
        }
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
      
        guard user.followers != 0 else{
            presentGHAlertOnMainThread(title: "No Followers", message: "This user has no followers yet 😣.", buttonTitle: "OK")
            return
        }
        
        // tell follower list screen the new user
        delegate.didRequestFollowers(for: user.login)
        // dismiss vc
        dismissVC()
    }

    
}
