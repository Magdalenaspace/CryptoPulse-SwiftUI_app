//
//  TopMoversView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//
import SwiftUI

struct TopMoversView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Top Movers")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.topMovingCoins) { coin in
                        TopMoversItemView(coin: coin)
                    }
                }
            }
        }
    }
}

struct TopMoversView_Previews: PreviewProvider {
    static var previews: some View {
        TopMoversView(viewModel: HomeViewModel())
    }
}
