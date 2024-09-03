//
//  MatchListViewModel.swift
//  CSTV
//
//  Created by Lucas Brandão on 27/08/24.
//

import Foundation

protocol MatchListViewModelProtocol: ObservableObject {
    func fetchMatches()
    func fetchMoreMatches()
    var matches: Matches { get set }
    var isLoading: Bool { get set }
    var isLoadingMore: Bool { get set }
}

final class MatchListViewModel: MatchListViewModelProtocol {
    private let service: MatchListService
    @Published var matches: Matches = []
    @Published var isLoading: Bool = true
    @Published var isLoadingMore: Bool = false

    private var currentPage: Int = 1
    private var allDataFetched: Bool = false

    init(service: MatchListService) {
        self.service = service
    }

    func fetchMatches() {
        isLoading = true
        currentPage = 1
        
        service.loadMatches(completion: { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                    case .success(let matches):
                        if matches.isEmpty {
                            self.allDataFetched = true
                        } else {
                            self.matches = matches.compactMap { [weak self] match in
                                self?.mapMatch(match)
                            }
                        }
                    case .failure(let error):
                        debugPrint(error)
                }
            }
        })
    }

    func fetchMoreMatches() {
        guard !isLoadingMore && !allDataFetched else { return }

        isLoadingMore = true
        currentPage += 1

        service.getMatches(page: currentPage, completion: { result in
            DispatchQueue.main.async {
                self.isLoadingMore = false
                switch result {
                    case .success(let matches):
                        if matches.isEmpty {
                            self.allDataFetched = true
                        } else {
                            self.matches.append(contentsOf: matches.compactMap { [weak self] match in
                                self?.mapMatch(match)
                            })
                        }
                    case .failure(let error):
                        debugPrint(error)
                }
            }
        })
    }

    private func mapMatch(_ match: MatchResponse) -> Match {
        let homeTeam = match.opponents[safe: 0]?.opponent
        let homeScore = match.results.first(where: { $0.teamID == homeTeam?.id })?.score
        let awayTeam = match.opponents[safe: 1]?.opponent
        let awayScore = match.results.first(where: { $0.teamID == awayTeam?.id })?.score
        return Match(
            leagueAndSerie: match.league.name + " + " + match.serie.name,
            leagueImageUrl: match.league.imageURL ?? "",
            homeTeam: homeTeam,
            homeTeamScore: homeScore ?? 0,
            awayTeam: awayTeam,
            awayTeamScore: awayScore ?? 0,
            status: Status(rawValue: match.status) ?? .notStarted,
            beginAt: match.beginAt ?? ""
        )
    }
}
