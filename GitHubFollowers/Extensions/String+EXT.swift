//
//  String+EXT.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 03/04/2024.
//

import Foundation
extension String{
    func convertToDate()-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat()->String{
        guard let date = self.convertToDate() else {return "Not Available"}
        
        return date.convertToMonthYear()
    }

}
