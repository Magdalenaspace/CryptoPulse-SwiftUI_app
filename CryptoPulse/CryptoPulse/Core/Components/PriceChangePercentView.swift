//
//  PriceChangePercentView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI

struct PriceChangePercentView: View {
    let percentageChange: Double
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "triangle.fill")
                .resizable()
                .rotationEffect(.degrees(percentageChange > 0 ? 180 : 0))
                .frame(width: 10, height: 8)
                .rotationEffect(.degrees(180))
            
            Text(percentageChange.asPercentString())
                .font(.subheadline)
                .bold()
        }
        .padding(10)
        .background(Color(percentageChange > 0 ? .systemGreen : .systemRed))
        .cornerRadius(8)
        .foregroundColor(.white)
        .shadow(color: Color.theme.accent.opacity(0.25), radius: 4, x: 0, y: 0)
    }
}

struct PriceChangePercentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PriceChangePercentView(percentageChange: -1.45)
                .previewLayout(.sizeThatFits)
                .padding()
            
            PriceChangePercentView(percentageChange: -1.45)
                .previewLayout(.sizeThatFits)
                .padding()
                .preferredColorScheme(.dark)
        }
    }
}
