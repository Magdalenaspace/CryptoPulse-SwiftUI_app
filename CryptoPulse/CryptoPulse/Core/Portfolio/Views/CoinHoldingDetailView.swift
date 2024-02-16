//
//  CoinHoldingDetailView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI
import Kingfisher

struct CoinHoldingDetailView: View {
    let holding: Holding
    @Environment(\.presentationMode) var mode
    @State private var showTransactionDetailView = false
    @State private var showNewTransactionView = false
    @State private var selectedTransaction: Transaction?
    @ObservedObject var viewModel: CoinHoldingDetailViewModel

    init(holding: Holding) {
        self.holding = holding
        self.viewModel = CoinHoldingDetailViewModel(holding: holding)
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                
                headerView
                
                Spacer()
                
                coinPricingInfoView
                
                sectionTitleView
                
                if let coin = holding.coin {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(viewModel.transactions) { transaction in
                            TransactionRowView(coin: coin, transaction: transaction)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        selectedTransaction = transaction
                                        showTransactionDetailView.toggle()
                                    }
                                }
                        }
                    }
                }
                
                TransactionButtonView(showNewTransactionView: $showNewTransactionView)
                    .padding(.horizontal)
            }
            
            if showTransactionDetailView, let transaction = selectedTransaction {
                withAnimation(.easeInOut) {
                    TransactionDetailsCardView(showCardView: $showTransactionDetailView,
                                               transaction: transaction)
                        .transition(.move(edge: .bottom))
                }
            }
        }
        .sheet(isPresented: $showNewTransactionView, onDismiss: viewModel.fetchTransactions) {
            if let coin = holding.coin {
                NewTransactionView(coin: coin, config: .updateHolding(holding))
            }
        }
    }
}

struct CoinHoldingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinHoldingDetailView(holding: dev.holding)
            .preferredColorScheme(.dark)
    }
}

// MARK: - UI Components

extension CoinHoldingDetailView {
    
    var coinInfoView: some View {
        HStack(spacing: 12) {
            KFImage(URL(string: holding.coin?.image ?? ""))
                .resizable()
                .frame(width: 24, height: 24)
            
            HStack(spacing: 2) {
                Text(holding.coin?.name.capitalized ?? "")
                    .font(.subheadline)
                
                Text("(\(holding.coin?.symbol.uppercased() ?? ""))")
                    .font(.caption)
            }
            .foregroundColor(Color.theme.accent)
            
            Spacer()
        }
    }
    
    var headerView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button {
                mode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.leading)
            
            
            coinInfoView
                .padding(.leading)
            
            HStack {
                Text(holding.dollarAmount.asCurrencyWith2Decimals())
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Spacer()
                
                PriceChangePercentView(percentageChange: holding.coin?.priceChangePercentage24H ?? 0)
            }
            .padding(.horizontal)
            
            Text("\(holding.amount.asNumberWith2Decimals()) \(holding.coin?.symbol.uppercased() ?? "")")
                .font(.footnote)
                .foregroundColor(Color.theme.accent)
                .padding(.leading)
        }
    }
    
    var coinPricingInfoView: some View {
        HStack(spacing: 4) {
            CoinHoldingDetailInfoView(config: .profitLoss(viewModel.netProfitLoss))
            
            Spacer()
            
            CoinHoldingDetailInfoView(config: .averagePrice(holding.averageCost))
        }
        .padding(.horizontal)
    }
    
    var sectionTitleView: some View {
        HStack {
            Text("Transactions")
                .font(.title3).bold()
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("See All")
                    .font(.caption).bold()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
            }
        }
        .padding(6)
        .padding(.top, 20)
    }
}
