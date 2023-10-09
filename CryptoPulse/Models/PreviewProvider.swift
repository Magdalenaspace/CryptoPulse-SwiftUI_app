//
//  PreviewProvider.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 10/6/23.
//

import SwiftUI


extension PreviewProvider {
    //created once
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    
    let stat1 = StatisticModel(title: "Current Price",
                               value: "$21,300,00",
                               percentageChange: 1.23)
    
    let stat2 = StatisticModel(title: "Market Capitalisation",
                       value: "$21.300n",
                       percentageChange: nil)
    
    let stat3 = StatisticModel(title: "Rank",
                                 value: "1",
                                 percentageChange: nil)
    
    let stat4 = StatisticModel(title: "Volume",
                               value: "$21.99bn",
                               percentageChange: nil)
    
    let sectionModel  = CoinDetailSectionModel(title: "OverView",
                                               stats: [StatisticModel(title: "Current Price",
                                                                      value: "$21,300,00",
                                                                      percentageChange: 1.23),
                                                       StatisticModel(title: "Market Capitalisation",
                                                                      value: "$21.300n",
                                                                      percentageChange: nil),
                                                       StatisticModel(title: "Rank", 
                                                                      value: "1",
                                                                      percentageChange: nil),
                                                       StatisticModel(title: "Volume",
                                                                      value: "$21.99bn",
                                                                      percentageChange: nil)])
}
