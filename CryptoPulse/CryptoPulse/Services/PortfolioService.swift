//
//  PortfolioService.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import FirebaseFirestoreSwift
import Firebase

struct PortfolioService {
    
    static func fetchUserPortfolio(completion: @escaping(Portfolio) -> Void) {
        print("DEBUG: Did call fetch user portfolio")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        print("DEBUG: Logged in user id \(uid)")
                
        COLLECTION_USERS.document(uid).collection("user-portfolio").getDocuments { snapshot, _ in
            print("DEBUG: Did enter completion block..")
            guard let documents = snapshot?.documents else { return }
            
            let holdings = documents.compactMap({ try? $0.data(as: Holding.self) })
            print("DEBUG: Did fetch user portfolio")
            completion(Portfolio(holdings: holdings))
        }
    }
    
    static func updateHolding(_ holding: Holding,
                              transactionType: TransactionType,
                              quantity: Double) {
        guard let uid = AuthViewModel.shared.user?.uid else { return }

        if transactionType == .sell {
            // notify user that this is invalid transaction
            guard holding.amount >= quantity else { return }
        }
        
        let updatedAmount = transactionType == .buy ?
        quantity + holding.amount :
        holding.amount - quantity
        
        let updatedAverageCost = holding.computeAverageBuyPrice(quantity: quantity, updatedAmount: updatedAmount)
        
        let data: [String: Any] = ["amount": updatedAmount,
                                   "coinID": holding.coinID,
                                   "averageCost": updatedAverageCost]
        
        COLLECTION_USERS.document(uid).collection("user-portfolio")
            .document(holding.coinID)
            .updateData(data)
    }
    
    static func createHolding(amount: Double, coinPrice:Double, coinID: String, completion: ((Error?) -> Void)?) {
        guard let uid = AuthViewModel.shared.user?.uid else { return }

        let data: [String: Any] = ["amount": amount,
                                   "coinID": coinID,
                                   "averageCost": coinPrice]
        
        COLLECTION_USERS.document(uid).collection("user-portfolio")
            .document(coinID)
            .setData(data, completion: completion)
        
    }
    
    static func updateHoldingAfterTransactionDelete(transaction: Transaction,
                                                    portfolio: Portfolio,
                                                    completion: @escaping(Double) -> Void) {
        guard let uid = AuthViewModel.shared.user?.uid else { return }

        var currentHoldingAmount = portfolio.holdings.first(where: { $0.coinID == transaction.coinID })?.amount ?? 0
        
        if transaction.type == .buy {
            currentHoldingAmount -= transaction.quantity
        } else {
            currentHoldingAmount += transaction.quantity
        }
        
        COLLECTION_USERS.document(uid).collection("user-portfolio")
            .document(transaction.coinID)
            .updateData(["amount": currentHoldingAmount]) { _ in
                completion(currentHoldingAmount)
            }
    }
}

//    static func updateHolding(forTransactionType type: TransactionType,
//                              quantity: Double,
//                              coinID: String,
//                              portfolio: Portfolio,
//                              completion: ((Error?) -> Void)?) {
//        guard let uid = AuthViewModel.shared.user?.uid else { return }
//
//        let currentHoldingAmount = portfolio.holdings.first(where: { $0.coinID == coinID })?.amount ?? 0
//
//        if type == .sell {
//            // notify user that this is invalid transaction
//            guard currentHoldingAmount >= quantity else { return }
//        }
//
//        let updatedAmount = type == .buy ?
//        quantity + currentHoldingAmount :
//        currentHoldingAmount - quantity
//
//        let data: [String: Any] = ["amount": updatedAmount,
//                                   "coinID": coinID]
//
//        let ref = COLLECTION_USERS.document(uid).collection("user-portfolio").document(coinID)
//
//        if type == .buy {
//            ref.setData(data, completion: completion)
//        } else {
//            ref.updateData(["amount": updatedAmount], completion: completion)
//        }
//    }
