//
//  Provider.swift
//  Meconnect Login
//
//  Created by Srijan on 04/08/21.
//

import Combine
import Foundation

class Provider {
  static var shared = Provider()

  func requestPublisher<T: Codable>(_ request: URLRequest) -> AnyPublisher<T, ProviderError> {
    URLSession.shared.dataTaskPublisher(for: request)
      .mapError { .network(error: $0) }
      .flatMap { self.requestDecoder(data: $0.data) }
      .eraseToAnyPublisher()
  }
}

// MARK: - Encode/Decode Requests

extension Provider {
  private func requestDecoder<T: Codable>(data: Data) -> AnyPublisher<T, ProviderError> {
    let decoder = JSONDecoder()
    do{
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
        print(json)
    }catch{
        print("erroMsg")
        
    }

    return Just(data)
      .tryMap { try decoder.decode(T.self, from: $0) }
      .mapError { .decoding(error: $0) }
      .eraseToAnyPublisher()
  }

  func requestEncoder<T: Codable>(data: T) -> AnyPublisher<Data, ProviderError> {
    return Just(data)
      .tryMap { try JSONEncoder().encode($0) }
      .mapError { .encoding(error: $0) }
      .eraseToAnyPublisher()
  }
}

