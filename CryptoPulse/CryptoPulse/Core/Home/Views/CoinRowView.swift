//
//  CoinRowView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI
import Kingfisher

struct CoinRowView: View {
    let coin: Coin
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 24)
            
            KFImage(URL(string: coin.image))
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading, 4)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(Color.theme.accent)
                
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .padding(.leading, 6)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.leading, 2)
            
            Spacer()
            
//            ChartView(coin: coin, isCompactView: true)
//                .frame(width: 72, height: 32)
//            
//            Spacer()
                        
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                    .bold()
                    .foregroundColor(Color.theme.accent)
                
                Text(coin.priceChangePercentage24H.asPercentString())
                    .foregroundColor(
                        coin.priceChangePercentage24H >= 0 ?
                        Color.theme.green : Color.theme.red
                    )
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
