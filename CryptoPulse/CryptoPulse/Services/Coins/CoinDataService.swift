//
//  CoinDataService.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins = [Coin]()
    
    var timer: Timer?
    var coinSubscription: AnyCancellable?
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=true&price_change_percentage=24h"
    
    init() {
        fetchCoinsAndStartTimer()
    }
    
    func fetchCoinsAndStartTimer() {
        fetchCoins()
        refreshData()
    }
    
    private func fetchCoins() {
        NetworkManager.download(withUrlString: urlString) { data, error in
            guard let data = data else { return }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                self.allCoins = coins
            } catch let error {
                print("DEBUG: Error \(error.localizedDescription)")
            }
        }
    }
    
    private func refreshData() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            self.fetchCoins()
        }
    }
    
    //    private func fetchCoins() {
    //        guard let url = URL(string: urlString) else { return }
    //
    //        coinSubscription = NetworkManager.download(url: url)
    //            .decode(type: [Coin].self, decoder: JSONDecoder())
    //            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] coins in
    //                self?.allCoins = coins
    //                self?.coinSubscription?.cancel()
    //            })
    //    }
}
