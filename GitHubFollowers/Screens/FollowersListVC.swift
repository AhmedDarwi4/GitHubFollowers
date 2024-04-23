//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 08/03/2024.
//

import UIKit

protocol FollowerVCDelegate: AnyObject{
    func didRequestFollowers(for username:String)
}

class FollowersListVC: UIViewController {
    
    enum Section{
        case Main
    }
    
    var userName:String?
    var followers:[Follower] = []
    var filteredFollowers:[Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var collectionView:UICollectionView!
    var dataSource:UICollectionViewDiffableDataSource<Section,Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureCollectionView()
        configureSerarchController()
        getFollowers(username: userName ?? "", page: page)
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - ConfigureViewController
    
    func configureVC(){
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addbutton  = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addbutton
    }
    
    
    // MARK: - ConfigureCollectionView
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout:UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.cellIdentifier)
        collectionView.backgroundColor = .secondarySystemBackground
    }
    
    // MARK: - ConfigureSearchController
    
    func configureSerarchController(){
        let searchController  = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
    }
    
    
    // MARK: - GetFollowers
    
    func getFollowers(username:String,page:Int){
        showloadingView()
        NetworkManager.shared.getfollowers(for: userName ?? "", page: page) {[weak self] result in
            guard let self = self else{return}
            dismissLoadingView()
            switch result{
            case.success(let followers):
                
                if followers.count < 100{
                    hasMoreFollowers = false
                }
                print("Followers Count:\(followers.count)")
                self.followers.append(contentsOf: followers)
                
                if followers.isEmpty{
                    let message = "This user doesn`t have any followers yet.Go follow them 😊"
                    DispatchQueue.main.async {self.showEmptyStateView(message: message, in: self.view)}
                    return
                }
                
                self.updateData(on: self.followers)
            case.failure(let failure):
                self.presentGHAlertOnMainThread(title: "Bad stuff Happened", message:failure.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    // MARK: - ConfigureDataSource
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.cellIdentifier, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    // MARK: - UpdateData
    
    func updateData(on followers:[Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.Main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
        
    }
    
}

extension FollowersListVC:UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height{
            guard hasMoreFollowers else{return}
            page+=1
            getFollowers(username: userName ?? "", page: page)
        }
        
        //        print("OffsetY:\(offsetY)")
        //        print("contentHeight:\(contentHeight)")
        //        print("height:\(height)")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}

extension FollowersListVC:UISearchResultsUpdating,UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text , !filter.isEmpty else{return}
        isSearching = true
        filteredFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
        isSearching = false
    }
}

extension FollowersListVC:FollowerVCDelegate{
    func didRequestFollowers(for username: String) {
        self.userName  = username
        title          = username
        page           = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
        
    }
    
    @objc func addButtonTapped(){
        showloadingView()
        NetworkManager.shared.getUserInfo(for: userName ?? "") { [weak self] result in
            guard let self = self else{return}
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else{return}
                    guard let error  = error else{
                        presentGHAlertOnMainThread(title: "Success!", message: "You`ve successfully favourited this user 🎉", buttonTitle: "Hooray!")
                        return
                    }
                    presentGHAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                }
            case .failure(let failure):
                presentGHAlertOnMainThread(title: "Something went wrong", message: failure.rawValue, buttonTitle: "OK")
            }
        }
        
    }
    
    
}
