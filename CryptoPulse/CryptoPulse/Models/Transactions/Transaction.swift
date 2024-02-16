//
//  TransactionDetail.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import Firebase
import FirebaseFirestoreSwift
import SwiftUI

struct Transaction: Identifiable, Decodable {
    @DocumentID var id: String?
    let type: TransactionType
    let date: Timestamp
    let price: Double
    let quantity: Double
    let fee: Double
    let cost: Double
    let coinID: String
    
    var dateString: String {
        return date.dateValue().dateString()
    }
}

enum TransactionType: Int, Decodable {
    case buy
    case sell
    
    var description: String {
        switch self {
        case .buy: return "Buy"
        case .sell: return "Sell"
        }
    }
    
    var imageName: String {
        switch self {
        case .buy: return "arrow.down.circle.fill"
        case .sell: return "arrow.up.circle.fill"
        }
    }
    
    var imageForegroundColor: Color {
        switch self {
        case .buy: return Color(.systemBlue)
        case .sell: return Color(.systemRed)
        }
    }
}
