//
//  CircleButtonView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//


import SwiftUI

struct CircleButtonView: View {
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(imageName: "chevron.right")
                .previewLayout(.sizeThatFits)
            
            CircleButtonView(imageName: "info")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}
