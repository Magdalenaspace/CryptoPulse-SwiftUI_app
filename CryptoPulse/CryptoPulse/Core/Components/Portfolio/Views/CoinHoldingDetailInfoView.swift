//
//  CoinHoldingDetailInfoView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI

struct CoinHoldingDetailInfoView: View {
    let config: CoinHoldingDetailInfoConfig
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.theme.itemBackgroundColor
            
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: config.iconImageName)
                    .foregroundStyle(.white, config.iconForegroundColor)
                    .font(.largeTitle)
                
                Text(config.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.top, 6)
                    .opacity(0.87)
                
                Text(config.valueString)
                    .font(.title3).bold()
            }
            .padding()
        }
        .frame(width: 164, height: 164)
        .cornerRadius(10)
    }
}

struct CoinHoldingDetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinHoldingDetailInfoView(config: .profitLoss(3.65))
                .previewLayout(.sizeThatFits)
            
            CoinHoldingDetailInfoView(config: .averagePrice(2687.63))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
