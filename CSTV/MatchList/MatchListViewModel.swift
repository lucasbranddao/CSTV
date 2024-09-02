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
    var isLoading: Bool { get set }
}

final class MatchListViewModel: MatchListViewModelProtocol {
    private let service: MatchListService
    @Published var matches: Matches = []
    @Published var isLoading: Bool = true

    init(service: MatchListService) {
        self.service = service
    }
    
    func fetchMatches() {
        service.getMatches(completion: { result in
            switch result {
                case .success(let matches):
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.matches = matches.compactMap({ match in
                            Match(
                                leagueAndSerie: match.league.name + " + " + match.serie.name,
                                leagueImageUrl: match.league.imageURL ?? "",
                                homeTeam: match.opponents[safe: 0]?.opponent,
                                awayTeam: match.opponents[safe: 1]?.opponent,
                                status: Status(rawValue: match.status) ?? .notStarted,
                                beginAt: match.beginAt ?? ""
                            )
                        })
                    }

                case  .failure(let error):
                    debugPrint(error)
            }
        })
    }
}
