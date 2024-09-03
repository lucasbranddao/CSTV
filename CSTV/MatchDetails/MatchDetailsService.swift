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

    func getPlayers(id: Int, completion: @escaping (Swift.Result<PlayersResponse, Error>) -> Void) {
        guard let apiUrl else { return }
        var request = URLRequest(url: apiUrl.appending(path: "/\(id)"))
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer g2TV5SyVD7bTgvBmg05aE8MujczOku_8oX0nmSreRRQhFZOQx5o", forHTTPHeaderField: "Authorization")


        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "No data received"])
                completion(.failure(error))
                return
            }

            do {
                let decoder = JSONDecoder()
                let matchDetails = try decoder.decode(PlayersResponse.self, from: data)
                completion(.success(matchDetails))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
