//
//  PortfolioHeader.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI

struct PortfolioHeader: View {
    var animation: Namespace.ID
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(#colorLiteral(red: 0.6722137332, green: 0.5048282743, blue: 0.9994676709, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))], startPoint: .center, endPoint: .bottomTrailing)
            
            VStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Portfolio")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
//                        Image(systemName: "arrow.right")
                    }
                    
                    if let portfolio = viewModel.user?.portfolio {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(portfolio.netValue.asCurrencyWith2Decimals())
                                    .font(.title2).bold()
                                    .opacity(0.95)
                                
                                Text("Your current balance")
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
                            VStack(spacing: 4) {
                                Text((portfolio.netProfitLoss24H >= 0 ? "+" : "") + portfolio.netProfitLoss24H.asPercentString())
                                    .font(.title3)
                                    .bold()
                                
                                Text("Today")
                                    .font(.caption)
                            }
                        }
                        .padding(.top, 8)
                    } else {
                        Text("Sign in to create your portfolio")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .opacity(0.95)
                    }
                }
                .foregroundColor(.white)
                .padding()
                
                Spacer()
            }
        }
        .cornerRadius(10)
        .shadow(color: Color.theme.accent.opacity(0.25), radius: 12, x: 0, y: 0)
    }
}

//struct PortfolioHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        PortfolioHeader()
//    }
//}
