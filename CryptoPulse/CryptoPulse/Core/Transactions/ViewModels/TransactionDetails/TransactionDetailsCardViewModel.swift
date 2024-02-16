//
//  TransactionDetailsCardViewModel.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import Foundation

class TransactionDetailsCardViewModel: ObservableObject {
    
    let transaction: Transaction
    private let service: TransactionService
    @Published var error: Error?
    @Published var deletionComplete = false
    
    init(transaction: Transaction) {
        self.transaction = transaction
        self.service = TransactionService(coinID: transaction.coinID)
    }
    
    func deleteTransaction() {
        service.deleteTransaction(transaction: transaction) { error in
            if let error = error {
                self.error = error
                return
            }

            guard let portfolio = AuthViewModel.shared.user?.portfolio else { return }

            PortfolioService.updateHoldingAfterTransactionDelete(transaction: self.transaction,
                                                                 portfolio: portfolio) { updatedHoldingAmount in
                
                guard let holdingIndex = portfolio.holdings.firstIndex(where: { $0.coinID == self.transaction.coinID }) else { return }
                AuthViewModel.shared.user?.portfolio?.holdings[holdingIndex].amount = updatedHoldingAmount
                self.deletionComplete = true
            }
        }
    }
}
