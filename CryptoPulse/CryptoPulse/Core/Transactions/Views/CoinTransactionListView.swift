//
//  CoinTransactionListView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI

/*
 
 BUG:
 for some reason using this file was causing the init to run 4 times
 extracted the scroll view component and placed in CoinHoldingDetailView.swift
 
*/

//struct CoinTransactionListView: View {
//    let coin: Coin
//    @Binding var showTransactionDetailView: Bool
//    @Binding var selectedTransaction: Transaction?
//    @ObservedObject var viewModel: TransactionViewModel
//    
//    init(coin: Coin,
//         showTransactionDetailView: Binding<Bool>,
//         selectedTransaction: Binding<Transaction?>) {
//                
//        self.coin = coin
//        self._showTransactionDetailView = showTransactionDetailView
//        self.viewModel = TransactionViewModel(coin: coin)
//        self._selectedTransaction = selectedTransaction
//    }
//    
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false) {
//            ForEach(viewModel.transactions) { transaction in
//                TransactionRowView(coin: coin, transaction: transaction)
//                    .onTapGesture {
//                        withAnimation(.easeInOut) {
//                            selectedTransaction = transaction
//                            showTransactionDetailView.toggle()
//                        }
//                    }
//            }
//        }
//    }
//}
//
//struct CoinTractionListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinTransactionListView(coin: dev.coin, showTransactionDetailView: .constant(false), selectedTransaction: .constant(nil))
//    }
//}
//
//
