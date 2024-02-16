//
//  TransactionDetailsCardView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI

struct TransactionDetailsCardView: View {
    @Binding var showCardView: Bool
    @ObservedObject var viewModel: TransactionDetailsCardViewModel
    
    init(showCardView: Binding<Bool>, transaction: Transaction) {
        self._showCardView = showCardView
        self.viewModel = TransactionDetailsCardViewModel(transaction: transaction)
    }
    
    var body: some View {
        VStack {
            Spacer()
                        
            VStack(spacing: 16) {
                
                Capsule()
                    .frame(width: 40, height: 4)
                    .foregroundColor(Color.white.opacity(0.7))
                    .padding()
                    .frame(maxWidth: .infinity)
                
                HStack {
                    Text("Transaction Details")
                        .font(.system(size: 18, weight: .semibold))
                        .padding()
                    
                    Spacer()
                }
                
                ForEach(TransactionDetailViewModel.allCases, id: \.rawValue) { detail in
                    TransactionDetailRowView(viewModel: detail,
                                             detail: detail.data(forTransactionDetail: viewModel.transaction))
                }
                .padding(.horizontal)
                
                Button {
                    viewModel.deleteTransaction()
                } label: {
                    Text("Delete Transaction")
                        .font(.subheadline).bold()
                        .foregroundColor(.white)
                        .frame(width: 300, height: 44)
                        .background(Color(.systemRed))
                        .cornerRadius(10)
                }
                .padding(.bottom, 40)
            }
            .background(Color.theme.itemBackgroundColor)
            .cornerRadius(10)
        }
        .onReceive(viewModel.$deletionComplete, perform: { didDelete in
            if didDelete {
                showCardView.toggle()
            }
        })
        .ignoresSafeArea()
        .background(Color(.black).opacity(0.6))
        .onTapGesture {
            withAnimation(.easeInOut) {
                showCardView.toggle()
            }
        }
    }
}

struct TransactionDetailsCardView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsCardView(showCardView: .constant(false), transaction: dev.transactionDetail)
            .preferredColorScheme(.dark)
    }
}
