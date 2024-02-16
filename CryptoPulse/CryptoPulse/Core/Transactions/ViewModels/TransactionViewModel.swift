//
//  PortfolioViewModel.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import Firebase
import FirebaseFirestoreSwift

import SwiftUI

class TransactionViewModel: ObservableObject {
    @Published var transactions = [Transaction]()
    private let coinID: String
    
    init(coinID: String) {
        self.coinID = coinID
    }
}
