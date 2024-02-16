//
//  PortfolioCoinRowView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI
import Kingfisher

struct PortfolioCoinRowView: View {
    let portfolio: Portfolio
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(portfolio.holdings) { holding in
                    if let coin = holding.coin {
                        NavigationLink {
                            LazyNavigationView(CoinHoldingDetailView(holding: holding)
                                                .navigationBarHidden(true))
                        } label: {
                            HStack(spacing: 16) {
                                KFImage(URL(string: coin.image))
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(coin.name)
                                        .font(.subheadline).bold()
                                    
                                    Text((holding.percentageOfPortfolio(portfolioNetValue: portfolio.netValue)).asPercentString())
                                        .font(.caption)
                                }
                                .foregroundColor(Color.theme.accent)
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("\(holding.amount.asNumberWith2Decimals()) \(coin.symbol.uppercased())")
                                        .font(.system(size: 14)).bold()
                                    
                                    Text("\(holding.dollarAmount.asCurrencyWith2Decimals())")
                                        .font(.caption)
                                }
                                .foregroundColor(Color.theme.accent)
                                
//                                Rectangle()
//                                    .foregroundColor(.white)
//                                    .frame(width: 0.5, height: 32)
//
//                                HStack(spacing: 4) {
//                                    Image(systemName: "arrow.up")
//                                        .font(.caption)
//                                        .foregroundColor(.green)
//
//                                    Text("27%")
//                                        .font(.caption)
//                                        .foregroundColor(.green)
//                                        .bold()
//                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical)
    }
}

struct PortfolioCoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioCoinRowView(portfolio: dev.user.portfolio!)
    }
}
