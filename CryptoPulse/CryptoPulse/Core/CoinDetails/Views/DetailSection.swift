//
//  DetailSection.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//


import SwiftUI

struct DetailSection: View {
    let title: String
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 20
    let items: [StatisticModel]
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title).bold()
                .foregroundColor(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: columns,
                      alignment: .leading,
                      spacing: spacing,
                      pinnedViews: []) {
                
                ForEach(items) { stat in
                    StatisticView(stat: stat)
                }
            }            
            
            Divider()
        }
    }
}

struct DetailSection_Previews: PreviewProvider {
    static var previews: some View {
        DetailSection(title: "Overview Details", items: [dev.stat1, dev.stat2, dev.stat3])
    }
}
