//
//  TopMoversItemView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI
import Kingfisher

struct TopMoversItemView: View {
    let coin: Coin
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            KFImage(URL(string: coin.image))
                .resizable()
                .frame(width: 32, height: 32)
                .clipShape(Circle())
                .padding(.bottom, 8)
            
            HStack(spacing: 2) {
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.theme.accent)
                                
                Text(coin.currentPrice.asCurrencyWith2Decimals())
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
            }
            .padding(.leading, 4)
            
            Text("+" + coin.priceChangePercentage24H.asPercentString())
                .font(.title2)
                .foregroundColor(.green)
        }
        
        .frame(width: 140, height: 140)
        .background(Color.white.opacity(0.05))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 2)
        )
    }
}

struct TopMoversItemView_Previews: PreviewProvider {
    static var previews: some View {
        TopMoversItemView(coin: dev.coin)
            .preferredColorScheme(.light)
    }
}
