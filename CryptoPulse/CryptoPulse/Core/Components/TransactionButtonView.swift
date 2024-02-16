//
//  TransactionButtonView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI

struct TransactionButtonView: View {
    @Binding var showNewTransactionView: Bool
    
    var body: some View {
        HStack {
            Button {
                showNewTransactionView.toggle()
            } label: {
                Text("Buy")
                    .font(.headline).bold()
                    .frame(width: UIScreen.main.bounds.width / 2 - 32, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(8)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Sell")
                    .font(.headline).bold()
                    .frame(width: UIScreen.main.bounds.width / 2 - 32, height: 44)
                    .background(Color(.systemRed))
                    .cornerRadius(8)
            }
        }
        .foregroundColor(.white)
    }
}

struct TransactionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionButtonView(showNewTransactionView: .constant(false))
                .previewLayout(.sizeThatFits)
                .padding()
            
            TransactionButtonView(showNewTransactionView: .constant(false))
                .previewLayout(.sizeThatFits)
                .padding()
                .preferredColorScheme(.dark)
        }
    }
}
