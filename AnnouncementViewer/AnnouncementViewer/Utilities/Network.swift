//
//  Network.swift
//  AnnouncementViewer
//
//  Created by Saiefeddine HAYOUNI on 18/10/2022.
//
import Foundation
import Combine

enum Error: Swift.Error {
    case network
}

struct Network {
    static let shared = Network()
    // use T optional
    // when nil show error view
    // when != nil show list
    func fetchData<T: Decodable>(from url: URL, defaultValue: T) -> AnyPublisher<Result<T, Error>, Never> {
        let decoder = JSONDecoder()
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .map { .success($0)  }
            .catch { (error) -> AnyPublisher<Result<T, Error>, Never> in
                return Just(.failure(.network)).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

}
