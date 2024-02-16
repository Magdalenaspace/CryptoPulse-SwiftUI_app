//
//  NetworkManager.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import Foundation
import Combine
import SwiftUI

class NetworkManager {
    
    enum NetworkError: LocalizedError {
        case badURLResponse(URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url): return "DEBUG: Bad response from URL: \(url)"
            case .unknown: return "DEBUG: Unknown error occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleUrlResponse(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("DEBUG: Fetch failed with error \(error.localizedDescription)")
        }
    }
    
    static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  throw NetworkError.badURLResponse(url)
              }
        
        return output.data
    }
    
    static func download(withUrlString urlString: String, completion: @escaping(Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DEBUG: Failed to fetch data with error \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            DispatchQueue.main.async {
                completion(data, nil)
            }
        }.resume()
    }
}
