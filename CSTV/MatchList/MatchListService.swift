//
//  MatchListService.swift
//  CSTV
//
//  Created by Lucas Brandão on 27/08/24.
//

import Foundation

final class MatchListService {

    private let baseUrl = "https://api.pandascore.co/matches"
    private let pageSize = 5

    func getMatches(page: Int, completion: @escaping (Result<MatchesResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)?page[size]=\(pageSize)&page[number]=\(page)&filter[videogame]=3&filter[opponents_filled]=true") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(APIConstants.token)", forHTTPHeaderField: "Authorization")

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

