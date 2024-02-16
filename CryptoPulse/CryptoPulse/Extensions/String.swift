//
//  String.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//



import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
