//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 17/03/2024.
//

import Foundation

enum GFError: String,Error{
    case invalidUsername = "This username created an invalid request.please try again."
    case internetIssue =  "Unable to complete your request.please check your internet connection"
    case invalidResponse = "Invalid response from the server.please try again."
    case invalidData = "The data received from the server was invalid.please try again."
    case unableToFavorite = "There was an error favoriting this user.please try again."
    case alreadyInFavourites = "you`ve already favorited this user!"
}
