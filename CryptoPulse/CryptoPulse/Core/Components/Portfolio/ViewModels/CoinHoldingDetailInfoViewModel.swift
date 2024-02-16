//
//  CoinHoldingDetailInfoViewModel.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI

enum CoinHoldingDetailInfoConfig {
    case profitLoss(Double)
    case averagePrice(Double)
    
    var title: String {
        switch self {
        case .profitLoss: return "Net Profit / Loss"
        case .averagePrice: return "Average Price"
        }
    }
    
    var iconForegroundColor: Color {
        switch self {
        case .profitLoss(let value):
            return value >= 0 ? Color(.systemGreen) : Color(.systemRed)
        case .averagePrice:
            return Color(.systemBlue)
        }
    }
    
    var iconImageName: String {
        switch self {
        case .profitLoss(let profitLoss):
            return profitLoss > 0 ? "arrow.up.right.circle.fill" : "arrow.down.right.circle.fill"
        case .averagePrice:
            return "dollarsign.circle.fill"
        }
    }
    
    var valueString: String {
        switch self {
        case .profitLoss(let value):
            return value.asPercentString()
        case .averagePrice(let value):
            return value.asCurrencyWith2Decimals()
        }
    }
}
