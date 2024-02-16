//
//  CoinDetailView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//


import SwiftUI
import Kingfisher
import SwiftUICharts

struct CoinDetailView: View {
    @StateObject var viewModel: CoinDetailsViewModel
    @State private var showNewTransactionView = false
    
    init(coin: Coin) {
        _viewModel = StateObject(wrappedValue: CoinDetailsViewModel(coin: coin))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    ChartView(coin: viewModel.coin, isCompactView: false)
                        .frame(height: 200)
                        .padding(.vertical)
                    
                    DetailSection(title: "Overview", items: viewModel.overviewStats)
                    
                    DetailSection(title: "Additional Details", items: viewModel.additionalStats)
                }
                .padding(8)
            }
            
            Button {
                showNewTransactionView.toggle()
            } label: {
                Text("Add Transaction")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 20)
            }
            .frame(maxWidth: .infinity)
            .background(Color.theme.itemBackgroundColor)

        }
        .navigationTitle(viewModel.coin.name)
        .sheet(isPresented: $showNewTransactionView, content: {
            NewTransactionView(coin: viewModel.coin, config: .newTransaction)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Text(viewModel.coin.symbol.uppercased())
                        .font(.headline)
                        .foregroundColor(Color.theme.secondaryText)
                    
                    KFImage(URL(string: viewModel.coin.image))
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CoinDetailView(coin: dev.coin)
        }
        .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portrait)
    }
}
