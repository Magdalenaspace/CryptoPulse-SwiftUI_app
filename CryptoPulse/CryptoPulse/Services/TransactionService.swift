//
//  TransactionService.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import Firebase
import FirebaseFirestoreSwift

struct TransactionService {
    
    private let coinID: String
    
    init(coinID: String) {
        self.coinID = coinID
    }
    
    func fetchTransactions(completion: @escaping([Transaction]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(uid).collection("user-transactions")
            .whereField("coinID", isEqualTo: coinID)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                let transactions = documents
                    .compactMap({ try? $0.data(as: Transaction.self) })
                    .sorted(by: { $0.date.dateValue() > $1.date.dateValue() })
                
                completion(transactions)
            }
    }
    
    func uploadTransaction(type: TransactionType,
                                  price: Double,
                                  fee: Double,
                                  amount: Double,
                                  totalCost: Double,
                                  completion: @escaping(Error?, Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
                
        let data: [String: Any] = ["type": type.rawValue,
                                   "quantity": amount,
                                   "fee": fee,
                                   "cost": totalCost,
                                   "price": price,
                                   "coinID": coinID,
                                   "date": Timestamp(date: Date())]
        
        COLLECTION_USERS.document(uid)
            .collection("user-transactions")
            .document()
            .setData(data) { error in
                
                if let error = error {
                    print("DEBUG: Error \(error.localizedDescription)")
                    completion(error, false)
                    return
                }
                
                completion(nil, true)
            }
    }
    
    func deleteTransaction(transaction: Transaction, completion: ((Error?) -> Void)?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let transactionID = transaction.id else { return }

        COLLECTION_USERS.document(uid).collection("user-transactions")
            .document(transactionID)
            .delete(completion: completion)
    }
}
