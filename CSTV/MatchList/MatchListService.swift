//
//  MatchListService.swift
//  CSTV
//
//  Created by Lucas Brandão on 27/08/24.
//

import Foundation
import Combine

final class MatchListService {
    private let baseUrl = "https://api.pandascore.co/csgo/matches"
    private let pageSize = 5
    private var cancellables = Set<AnyCancellable>()

    func loadMatches(completion: @escaping (Result<MatchesResponse, Error>) -> Void) {
        guard
            let runningMatchesUrl = URL(string: "\(baseUrl)/running?filter[opponents_filled]=true&page[size]=3&page[number]=1"),
            let nextMatchesUrl = URL(string: "\(baseUrl)?page[size]=\(pageSize)&page[number]=1&filter[tournament_id]=14450&filter[opponents_filled]=true")
        else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Invalid URL"])))
            return
        }

        let runningMatchesPublisher = NetworkService.shared.performRequest(with: runningMatchesUrl, responseType: MatchesResponse.self)
        let nextMatchesPublisher = NetworkService.shared.performRequest(with: nextMatchesUrl, responseType: MatchesResponse.self)

        Publishers.Zip(runningMatchesPublisher, nextMatchesPublisher)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionStatus in
                switch completionStatus {
                    case .finished:
                        break
                    case .failure(let error):
                        completion(.failure(error))
                }
            }, receiveValue: { runningMatches, nextMatches in
                let combinedMatches = runningMatches + nextMatches
                completion(.success(combinedMatches))
            })
            .store(in: &cancellables)
    }

    func getMatches(page: Int, completion: @escaping (Result<MatchesResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)?page[size]=\(pageSize)&page[number]=\(page)&filter[tournament_id]=14450&filter[opponents_filled]=true") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Invalid URL"])))
            return
        }

        NetworkService.shared.performRequest(with: url, responseType: MatchesResponse.self, completion: completion)
    }
}

