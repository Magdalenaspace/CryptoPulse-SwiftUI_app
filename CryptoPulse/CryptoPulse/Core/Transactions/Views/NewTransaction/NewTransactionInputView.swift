//
//  NewTransactionInputView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI

struct NewTransactionInputView: View {
    let title: String
    let currencyType: String
    let placeholderText: String
    @Binding var amount: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(Color.theme.secondaryText)
                
                Spacer()
                
                TextField(placeholderText, text: $amount)
                    .foregroundColor(Color.theme.secondaryText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)

                Text(currencyType)
            }
            .padding(8)
            .font(.footnote)
            
            Divider()
                .padding(.horizontal, 6)
        }
        .padding(.horizontal, 4)
    }
}

struct NewTransactionInputView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionInputView(title: "Buy Price", currencyType: "USD", placeholderText: "35106.36", amount: .constant(""))
    }
}
