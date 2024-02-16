//
//  CoinHoldingDetailViewModel.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import Foundation

class CoinHoldingDetailViewModel: ObservableObject {
    private let holding: Holding
    @Published var transactions = [Transaction]()
    @Published var averageCost: Double = 0
    @Published var netProfitLoss: Double = 0
    
    private let service: TransactionService
    
    init(holding: Holding) {
        self.holding = holding
        self.service = TransactionService(coinID: holding.coinID)
        fetchTransactions()
    }
    
    func fetchTransactions() {
        if !transactions.isEmpty {
            transactions.removeAll()
        }
        
        service.fetchTransactions { transactions in
            self.transactions = transactions
            
//            self.computeAverageBuyPrice()
            self.computeNetProfitLoss()
        }
    }
    
    func computeNetProfitLoss() {
        guard let coin = holding.coin else { return }
        self.netProfitLoss = ((coin.currentPrice / holding.averageCost) - 1) * 100
    }
    
//    func computeAverageBuyPrice() {
//        guard !transactions.isEmpty else { return }
//        var sum = 0.0
//
//        transactions.forEach { transaction in
//            if transaction.type == .buy {
//                sum += transaction.price * transaction.quantity
//            } else {
//                sum -= transaction.price * transaction.quantity
//            }
//        }
//
//        self.averageCost = sum / holding.amount
//    }
}
