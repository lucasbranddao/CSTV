//
//  MatchListService.swift
//  CSTV
//
//  Created by Lucas Brandão on 27/08/24.
//

import Foundation

protocol MatchListServiceProtocol {
    func getMatches(completion: @escaping (Swift.Result<MatchesResponse, Error>) -> Void)
}

final class MatchListService: MatchListServiceProtocol {

    private let apiUrl = URL(string: "https://api.pandascore.co/matches?page[size]=10&page[number]=1&filter[videogame]=3&filter[opponents_filled]=true")

    func getMatches(completion: @escaping (Swift.Result<MatchesResponse, Error>) -> Void) {
        guard let apiUrl else { return }
        var request = URLRequest(url: apiUrl)
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
                let matchDetails = try decoder.decode(MatchesResponse.self, from: data)
                completion(.success(matchDetails))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
