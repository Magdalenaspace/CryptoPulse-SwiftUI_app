//
//  HomeViewHeader.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI

struct HomeViewHeader: View {
    @Binding var showSettings: Bool
    
    var body: some View {
        HStack {
            CircleButtonView(imageName: "person")
                .onTapGesture {
                    showSettings.toggle()
                }
            
            Spacer()
            
            Text("Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
            
            Spacer()
            
            CircleButtonView(imageName: "chevron.right")
//                .rotationEffect(.degrees(showPortfolio ? 180 : 0))
                .onTapGesture {
//                    withAnimation(.spring()) {
//                        showPortfolio.toggle()
//                    }
                }
        }
        .padding(.horizontal)
    }
}

struct HomeViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewHeader(showSettings: .constant(false))
    }
}
