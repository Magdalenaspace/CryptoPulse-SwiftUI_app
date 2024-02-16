//
//  CustomInputField.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//



import SwiftUI

struct CustomInputField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(Color.theme.accent)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color.theme.accent.opacity(0.4))
                        .font(.system(size: 15))
                }
                
                if isSecureField {
                    SecureField("", text: $text)
                        .font(.system(size: 15))
                } else {
                    TextField("", text: $text)
                        .font(.system(size: 15))
                }
            }
            .foregroundColor(Color.theme.accent)
            
            Rectangle()
                .foregroundColor(Color.theme.accent.opacity(0.4))
                .frame(width: UIScreen.main.bounds.width - 32, height: 0.7)
        }
    }
}
