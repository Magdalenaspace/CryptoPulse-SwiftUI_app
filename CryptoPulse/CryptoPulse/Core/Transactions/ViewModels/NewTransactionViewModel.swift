//
//  NewTransactionViewModel.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import Firebase
import SwiftUI
import FirebaseFirestoreSwift

class NewTransactionViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var transactionComplete = false
    @Published var error: Error?
    
    @Published var coinAmountString = ""
    @Published var feeString = ""
    @Published var transactionPriceString = ""
    
    private let coin: Coin
    private let config: NewTransactionConfig
    private let service: TransactionService
    
    // MARK: - Lifecycle
    
    init(coin: Coin, config: NewTransactionConfig) {
        self.coin = coin
        self.config = config
        self.service = TransactionService(coinID: coin.id)
    }
    
    // MARK: - Helpers
    
    var coinImageUrl: URL? {
        return URL(string: coin.image)
    }
    
    var transactionTotal: Double {
        guard let coinAmount = Double(coinAmountString) else { return 0 }
        guard let transactionPrice = Double(transactionPriceString) else { return 0 }
        let fee = Double(feeString) ?? 0
        
        return (coinAmount * transactionPrice) + fee
    }
    
    var coinSymbolString: String {
        return coin.symbol.uppercased()
    }
    
    var currentCoinPriceString: String {
        return coin.currentPrice.asCurrencyWith2Decimals()
    }
    
    private var percentageChangeIsPositive: Bool {
        return coin.priceChangePercentage24H > 0
    }
    
    var coinPercentage24HChangeString: String {
        return coin.priceChangePercentage24H.asPercentString()
    }
    
    var percentageChangeTextColor: Color {
        return percentageChangeIsPositive ? Color(.systemGreen) : Color(.systemRed)
    }
    
    // MARK: - API
    
    func uploadTransaction(type: TransactionType) {
        guard let coinAmount = Double(coinAmountString) else { return }
        guard let transactionPrice = Double(transactionPriceString) else { return }
        let fee = Double(feeString) ?? 0
        
        service.uploadTransaction(type: type,
                                  price: transactionPrice,
                                  fee: fee,
                                  amount: coinAmount,
                                  totalCost: transactionTotal) { error, transactionCompleted in
            
            if let error = error {
                self.error = error
                return
            }
            
            self.updatePortfolioHolding(forTransactionType: type, coinAmount: coinAmount)
            self.transactionComplete = transactionCompleted
        }
    }
    
    private func updatePortfolioHolding(forTransactionType type: TransactionType, coinAmount: Double) {
        switch config {
        case .newTransaction:
            guard let portfolio = AuthViewModel.shared.user?.portfolio else { return }
            
            if let holding = portfolio.holdings.first(where: { $0.coinID == coin.id }) {
                self.updateHolding(holding, transactionType: type, coinAmount: coinAmount)
            } else {
                self.createHolding(coinAmount: coinAmount)
            }
            
        case .updateHolding(let holding):
            updateHolding(holding, transactionType: type, coinAmount: coinAmount)
        }
    }
    
    private func updateHolding(_ holding: Holding, transactionType: TransactionType, coinAmount: Double) {
        PortfolioService.updateHolding(holding, transactionType: transactionType, quantity: coinAmount)
    }
    
    private func createHolding(coinAmount: Double) {
        PortfolioService.createHolding(amount: coinAmount, coinPrice: coin.currentPrice, coinID: coin.id) { _ in
            print("DEBUG: Created new holding..")
        }
    }
}
