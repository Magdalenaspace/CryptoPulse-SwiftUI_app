//
//  UserPortfolioView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI
import Kingfisher

struct UserPortfolioView: View {
    @Binding var show: Bool
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack {
                titleAndBackButtonView
                
                PortfolioDetailHeaderView(user: user)
                
                Spacer()
            }
            
            Text("My Coins")
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .padding(.leading)
                .padding(.bottom, 4)
            
            if let portfolio = user.portfolio {
                PortfolioCoinRowView(portfolio: portfolio)
            }
            
            Spacer()
        }
        .cornerRadius(20)
        .foregroundColor(.white)
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea()
    }
}

struct UserPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        UserPortfolioView(show: .constant(true), user: dev.user)
            .preferredColorScheme(.dark)
    }
}

extension UserPortfolioView {
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            
            Spacer()
            
            HStack(spacing: 24) {
                Text("Value")
                
                Text("Change")
            }

        }
        .font(.caption2)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    private var titleAndBackButtonView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button {
                withAnimation(.spring()) {
                    show.toggle()
                }
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundColor(Color.theme.accent)
            }
            
            Text("Portfolio")
                .font(.title).bold()
                .foregroundColor(Color.theme.accent)
        }
        .padding(.top, 64)
        .padding(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/*
 ACTION VIEW
 HStack {
     VStack {
         Button {
             
         } label: {
             Image(systemName: "arrow.up")
                 .padding(4)
                 .font(.footnote)
                 .background(Color(.systemPurple))
                 .foregroundColor(.white)
                 .cornerRadius(4)
         }
         
         Text("Send")
             .font(.caption)
             .bold()
             .foregroundColor(Color(.systemPurple))
     }
     
     Spacer()
     
     VStack {
         Button {
             
         } label: {
             Image(systemName: "arrow.down")
                 .padding(4)
                 .font(.footnote)
                 .background(Color(.systemPurple))
                 .foregroundColor(.white)
                 .cornerRadius(4)
         }
         
         Text("Receive")
             .font(.caption)
             .bold()
             .foregroundColor(Color(.systemPurple))
     }
     
     Spacer()
     
     VStack {
         Button {
             
         } label: {
             Image(systemName: "arrow.up")
                 .padding(4)
                 .font(.footnote)
                 .background(Color(.systemPurple))
                 .foregroundColor(.white)
                 .cornerRadius(4)
         }
         
         Text("Send")
             .font(.caption)
             .bold()
             .foregroundColor(Color(.systemPurple))
     }
 }
 .padding(.horizontal)
 .frame(width: 300, height: 68)
 .foregroundColor(Color.theme.accent)
 .background(Color.white)
 .cornerRadius(10)
 .padding(.top, -24)

 */

