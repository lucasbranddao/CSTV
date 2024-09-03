//
//  MatchDetailsService.swift
//  CSTV
//
//  Created by Lucas Brandão on 31/08/24.
//

import Foundation
import Combine

protocol MatchDetailsServiceProtocol {
    func getPlayersPublisher(id: Int) -> AnyPublisher<Players, Error>
}

final class MatchDetailsService: MatchDetailsServiceProtocol {

    private let apiUrl = URL(string: "https://api.pandascore.co/teams/")

    func getPlayersPublisher(id: Int) -> AnyPublisher<Players, Error> {
        return Future<Players, Error> { promise in
            self.getPlayers(id: id) { result in
                switch result {
                    case .success(let response):
                        promise(.success(response.players))
                    case .failure(let error):
                        promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func getPlayers(id: Int, completion: @escaping (Result<PlayersResponse, Error>) -> Void) {
        guard let apiUrl else { return }
        let finalUrl = apiUrl.appending(path: "/\(id)")
        NetworkService.shared.performRequest(with: finalUrl, responseType: PlayersResponse.self, completion: completion)
    }
}
