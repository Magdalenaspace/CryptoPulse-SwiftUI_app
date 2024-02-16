//
//  NewTransactionView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI
import Kingfisher

enum NewTransactionConfig {
    case newTransaction
    case updateHolding(Holding)
}

struct NewTransactionView: View {
    @ObservedObject var viewModel: NewTransactionViewModel
    @State private var transactionType: TransactionType = .buy
    @Environment(\.presentationMode) var presentationMode

    init(coin: Coin, config: NewTransactionConfig) {
        self.viewModel = NewTransactionViewModel(coin: coin, config: config)
    }
    
    var body: some View {
        VStack {
            navBar
            
            Capsule()
                .frame(width: 56, height: 6)
                .foregroundColor(Color(.darkGray))
                .padding(.vertical, 4)
            
            
            VStack {
                buySellCancelView
                
                VStack {
                    NewTransactionInputView(title: "\(transactionType == .buy ? "Buy" : "Sell") Price",
                                            currencyType: "USD",
                                            placeholderText: viewModel.currentCoinPriceString,
                                            amount: $viewModel.transactionPriceString)
                    
                    NewTransactionInputView(title: "Amount",
                                            currencyType: viewModel.coinSymbolString,
                                            placeholderText: "0",
                                            amount: $viewModel.coinAmountString)
                    
                    NewTransactionInputView(title: "Fee",
                                            currencyType: "USD",
                                            placeholderText: "$0.00",
                                            amount: $viewModel.feeString)
                    
                    HStack {
                        Text("Total")
                        
                        Spacer()
                        
                        Text("\(viewModel.transactionTotal.asCurrencyWith2Decimals())")
                    }
                    .font(.subheadline)
                    .padding(10)
                }
                
                Button {
                    viewModel.uploadTransaction(type: transactionType)
                } label: {
                    Text("Submit \(transactionType == .buy ? "Buy": "Sell") Order")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color(transactionType == .buy ? .systemGreen : .systemRed))
                        .cornerRadius(10)
                        .padding(.vertical)
                }

                
                Spacer()
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity)
            .background(Color.theme.itemBackgroundColor)
            .cornerRadius(20)
        }
        .onReceive(viewModel.$transactionComplete, perform: { didComplete in
            if didComplete {
                presentationMode.wrappedValue.dismiss()
            }
        })
        .background(Color.black)
        .edgesIgnoringSafeArea(.bottom)
    }
}

extension NewTransactionView {
    var navBar: some View {
        HStack {
            Image(systemName: "chevron.left")
                .font(.title3)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
//                    KFImage(viewModel.coinImageUrl)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 20, height: 20)
//                        .clipShape(Circle())
                    
                    Text("\(viewModel.coinSymbolString) - USD")
                        .font(.footnote)
                        .fontWeight(.bold)
                }
                
                Text("New Transaction")
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
            }
            .padding(.leading, 8)
            
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(viewModel.currentCoinPriceString)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(viewModel.coinPercentage24HChangeString)
                    .font(.caption)
                    .foregroundColor(viewModel.percentageChangeTextColor)
            }
        }
        .padding(.top)
        .padding(.horizontal)
    }
    
    var buySellCancelView: some View {
        HStack {
            HStack(spacing: 16) {
                Text("BUY")
                    .fontWeight(.semibold)
                    .foregroundColor(transactionType == .buy ? Color(.systemGreen) : .white)
                    .onTapGesture {
                        withAnimation {
                            self.transactionType = .buy
                        }
                    }
                
                Text("SELL")
                    .fontWeight(.semibold)
                    .foregroundColor(transactionType == .sell ? Color(.red) : .white)
                    .onTapGesture {
                        withAnimation {
                            self.transactionType = .sell
                        }
                    }
            }
            .font(.caption)
            .padding(.horizontal, 20)
            .padding(.vertical, 6)
            .background(Color(.darkGray))
            .clipShape(Capsule())
            
            
            Spacer()
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.footnote)
                    .padding(8)
                    .background(Color(.darkGray))
                    .clipShape(Circle())
            }
        }
        .padding(20)
    }
}

struct NewTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionView(coin: dev.coin, config: .newTransaction)
            .preferredColorScheme(.dark)
    }
}
