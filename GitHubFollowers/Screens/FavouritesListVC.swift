//
//  FavouritesListVC.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 03/03/2024.
//

import UIKit

class FavouritesListVC: UIViewController {

    let tableView              = UITableView()
    var favorites: [Follower]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureVC(){
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
   func configureTableView(){
       view.addSubview(tableView)
       tableView.delegate      = self
       tableView.dataSource    = self
       tableView.rowHeight     = 80
       tableView.frame = view.bounds
       tableView.backgroundColor = .secondarySystemBackground
       tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.cellIdentifier)
      
    }
    
    func getFavorites(){
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let favourites):
                print(favourites)
                if favourites.isEmpty{
                    self.showEmptyStateView(message: "No Favorites?\nAdd one on the follower screen.", in: self.view)
                } else{
                    //  updateUI(with: favourites)
                          self.favorites = favourites
                          DispatchQueue.main.async {
                              self.tableView.reloadData()
                              self.view.bringSubviewToFront(self.tableView)
                          }
                }
                
            case .failure(let failure):
                presentGHAlertOnMainThread(title: "Something went wrong", message: failure.rawValue, buttonTitle: "OK")
            }
        }
    }
    
//    func updateUI(with favorites: [Follower]) {
//        if favorites.isEmpty {
//            self.showEmptyStateView(message: "No Favorites?\nAdd one on the follower screen.", in: self.view)
//        } else {
//            self.favorites = favorites
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//                self.view.bringSubviewToFront(self.tableView)
//            }
//        }
//    }
    
}

extension FavouritesListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.cellIdentifier) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowersListVC()
        destVC.userName = favorite.login
        destVC.title = favorite.login
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else{return}
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) {[weak self] error in
            guard let self = self else{return}
            guard let error = error else{return}
            self.presentGHAlertOnMainThread(title: "Unable to remove ", message: error.rawValue, buttonTitle: "OK")
        }
    }
    
    
}
