//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 06/04/2024.
//

import Foundation

enum persistenceActionType{
    case add,remove
}

enum PersistenceManager{
    
    private static let defaults = UserDefaults.standard
    enum Keys{
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite:Follower, actionType: persistenceActionType , completion: @escaping(GFError?)->Void){
        retrieveFavorites { result in
            switch result{
            case.success(let favorites):
                var retrievedFavorites = favorites
                switch actionType{
                case.add:
                    guard !retrievedFavorites.contains(favorite)else{
                        completion(.alreadyInFavourites)
                        return
                    }
                    retrievedFavorites.append(favorite)
                    
                case.remove:
                    retrievedFavorites.removeAll { $0.login == favorite.login }
                }
                
                completion(save(favorites: retrievedFavorites))
                
            case.failure(let error):
                completion(error)
            }
        }
    }
    
    
    static func retrieveFavorites(completion:@escaping(Result<[Follower],GFError>)->Void){
        guard let favoriteData = defaults.object(forKey: Keys.favorites) as? Data else{
            completion(.success([]))
            return
        }
        do{
            let decoder = JSONDecoder()
            let favorites =  try decoder.decode([Follower].self, from: favoriteData)
            completion(.success(favorites))
        }
        catch{
            completion(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites:[Follower])-> GFError?{
        do{
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        }
        catch{
            return.unableToFavorite
        }
        
    }
    
}
