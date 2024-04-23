//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Ahmed Darwish on 03/04/2024.
//

import Foundation

extension Date{
    func convertToMonthYear()-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
    
}
