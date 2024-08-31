//
//  MatchListViewModel.swift
//  CSTV
//
//  Created by Lucas Brandão on 27/08/24.
//

import Foundation

protocol MatchListViewModelProtocol: ObservableObject {
    func fetchMatches()
    var matches: Matches { get set }
}

final class MatchListViewModel: MatchListViewModelProtocol {
    private let service: MatchListService
    @Published var matches: Matches = []

    init(service: MatchListService) {
        self.service = service
    }
    
    func fetchMatches() {
        let mockedMatch = Match(leagueAndSerie: "ESL + North American", homeTeam: Team(name: "SK Gaming", imageURL: nil, id: 1), awayTeam: Team(name: "Team Liquid", imageURL: nil, id: 2), status: .notStarted, beginAt: "2024-08-29T16:00:00Z")
        self.matches = [mockedMatch]
        return

        service.getMatches(completion: { result in
            switch result {
                case .success(let matches):
                    DispatchQueue.main.async {
//                        self.matches = matches.compactMap({ Match(
//                            leagueAndSerie: $0.league.name + " + " + serie.name,
//                            homeTeam: $0.opponents[safe: 0]?.opponent,
//                            awayTeam: $0.opponents[safe: 1]?.opponent,
//                            status: Status(rawValue: $0.status) ?? .notStarted
//                        )})
                    }

                case  .failure(let error):
                    debugPrint(error)
            }
        })
    }
}
