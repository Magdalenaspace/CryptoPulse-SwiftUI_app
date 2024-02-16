//
//  User.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import Foundation

struct User: Decodable {
    let uid: String
    let fullname: String
    let email: String
    var portfolio: Portfolio?
}
