//
//  UIApplication.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//


import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
