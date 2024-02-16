//
//  TransactionDetailViewModel.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import Foundation


enum TransactionDetailViewModel: Int, CaseIterable {
    case type
    case date
    case price
    case quantity
    case fee
    case cost
    
    var title: String {
        switch self {
        case .type: return "Type"
        case .date: return "Date"
        case .price: return "Price Per Coin"
        case .quantity: return "Quantity"
        case .fee: return "Fee"
        case .cost: return "Cost"
        }
    }
    
    func data(forTransactionDetail detail: Transaction) -> String {
        switch self {
        case .type: return detail.type.description
        case .date: return detail.dateString
        case .price: return detail.price.asNumberWith2Decimals()
        case .quantity: return "\(detail.quantity)"
        case .fee: return detail.fee.asCurrencyWith2Decimals()
        case .cost: return detail.cost.asCurrencyWith2Decimals()
        }
    }
}
