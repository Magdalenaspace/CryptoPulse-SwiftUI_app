//
//  CoinDetailService.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import Foundation
import SwiftUI

class CoinDetailService {
    
    private let coin: Coin
    @Published var coinDetails: CoinDetails?
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        let urlString = "https://api.coingecko.com/api/v3/coins/\(coin.id)?tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        
        NetworkManager.download(withUrlString: urlString) { data, error in
            guard let data = data else { return }
            guard let details = try? JSONDecoder().decode(CoinDetails.self, from: data) else { return }
            
            self.coinDetails = details
        }
    }
}
