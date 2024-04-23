//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 16/03/2024.
//

import UIKit

class NetworkManager{
    static let shared = NetworkManager()
   private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString,UIImage>()
    private init(){}
    
    func getfollowers(for userName:String,page:Int,completion:@escaping(Result<[Follower],GFError>)->Void){
        let endPoint  = baseUrl + "\(userName)/followers?per_page=100&page=\(page)"
        guard let url  = URL(string: endPoint) else{
            completion(.failure(.invalidUsername))
            return
        }
        
        let task  = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handling the error
            if let _ = error{
                completion(.failure(.internetIssue))
                return
            }
            // Handling the response
            guard let response = response as?HTTPURLResponse,response.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            // Handling the data
            guard let data = data else{
                    completion(.failure(.invalidData))
                return
            }
            // Parsing the data
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                        completion(.success(followers))
            } catch{
                    completion(.failure(.invalidData))
            }
            
            
        }
        
        task.resume()
    }
    
    
    func getUserInfo(for userName:String,completion:@escaping(Result<User,GFError>)->Void){
        let endPoint  = baseUrl + "\(userName)"
        guard let url  = URL(string: endPoint) else{
            completion(.failure(.invalidUsername))
            return
        }
        
        let task  = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handling the error
            if let _ = error{
                completion(.failure(.internetIssue))
                return
            }
            // Handling the response
            guard let response = response as?HTTPURLResponse,response.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            // Handling the data
            guard let data = data else{
                    completion(.failure(.invalidData))
                return
            }
            // Parsing the data
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                        completion(.success(user))
            } catch{
                    completion(.failure(.invalidData))
            }
            
            
        }
        
        task.resume()
    }
}
