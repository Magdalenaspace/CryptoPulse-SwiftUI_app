//
//  PortfolioDetailHeaderView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI

struct PortfolioDetailHeaderView: View {
    let user: User
    
    var body: some View {
        VStack {
            HStack {
                PortfolioHeaderDetailItem(title: "Total Holdings",
                                          valueString: (user.portfolio?.netValue ?? 0).asCurrencyWith2Decimals(),
                                          alignment: .leading)
                    .padding(.leading)
                    .padding(.vertical, 8)
                
                Spacer()
                
                PortfolioHeaderDetailItem(title: "Net Change",
                                          valueString: user.portfolio?.netProfitLoss.asPercentString() ?? "",
                                          alignment: .trailing)
                    .padding(.vertical, 8)
                    .padding(.trailing)
            }
            
            HStack {
                PortfolioHeaderDetailItem(title: "Available Cash",
                                          valueString: (user.portfolio?.cashValue ?? 0).asCurrencyWith6Decimals(),
                                          alignment: .leading)
                    .padding(.leading)
                    .padding(.vertical, 8)
                
                Spacer()
                
                PortfolioHeaderDetailItem(title: "Investments",
                                          valueString: (user.portfolio?.investmentsValue ?? 0).asCurrencyWith2Decimals(),
                                          alignment: .trailing)
                    .padding(.trailing)
                    .padding(.vertical, 8)
            }
        }
        .frame(height: 200)
        .background( LinearGradient(colors: [Color(#colorLiteral(red: 0.6722137332, green: 0.5048282743, blue: 0.9994676709, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))], startPoint: .center, endPoint: .bottomTrailing))
        .cornerRadius(12)
        .padding(.horizontal)
        .shadow(color: Color.theme.accent.opacity(0.25), radius: 12, x: 0, y: 0)
    }
}

struct PortfolioDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioDetailHeaderView(user: dev.user)
    }
}

struct PortfolioHeaderDetailItem: View {
    let title: String
    let valueString: String
    let alignment: HorizontalAlignment
    
    var body: some View {
        VStack(alignment: alignment, spacing: 8) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .opacity(0.87)
            
            Text(valueString)
                .font(.system(size: 22, weight: .semibold))
        }
    }
}
