//
//  TransactionRowView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI

struct TransactionRowView: View {
    let coin: Coin
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: transaction.type.imageName)
                .foregroundStyle(.white, transaction.type.imageForegroundColor)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.type.description)
                    .font(.subheadline)
                
                Text(transaction.dateString)
                    .font(.caption)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(transaction.cost.asCurrencyWith2Decimals())
                
                Text("\(transaction.type == .buy ? "+" : "-")\(transaction.quantity.asNumberWith2Decimals()) \(coin.symbol.uppercased())")
                    .foregroundColor(transaction.type == .buy ? Color.theme.green : Color.theme.red)
            }
            .font(.caption)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
    }
}

struct TransactionRowView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRowView(coin: dev.coin, transaction: dev.transactionDetail)
    }
}
