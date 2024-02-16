//
//  Holding.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import Foundation

struct Holding: Identifiable, Decodable {
    var id: String { return coin?.id ?? "" }
    let coinID: String
    var amount: Double
    var averageCost: Double
    var coin: Coin?
    
    var dollarAmount: Double {
        guard let coin = coin else { return 0 }
        return coin.currentPrice * amount
    }
    
    func percentageOfPortfolio(portfolioNetValue: Double) -> Double {
        return (dollarAmount / portfolioNetValue) * 100
    }
    
    func computeAverageBuyPrice(quantity: Double, updatedAmount: Double) ->  Double {
        guard let coin = coin else { return 0 }
        
        let currentTotal = amount * averageCost
        let transactionTotal = quantity * coin.currentPrice
        let newTotal = currentTotal + transactionTotal
        
        return newTotal / updatedAmount
    }
    
    func computeNetProfitLoss() -> Double {
        guard let coin = coin else { return 0 }
        let netProfitLoss = ((coin.currentPrice / averageCost) - 1) * 100
        
        return netProfitLoss
    }
}
