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
            let mockedLeague = League(name: "ESL Pro League")

            // Mock Teams
            let team1 = Team(name: "Team Liquid", imageURL: "https://example.com/team-liquid-logo.png")
            let team2 = Team(name: "Astralis", imageURL: "https://example.com/astralis-logo.png")

            // Mock Opponents
            let opponent1 = Opponent(opponent: team1)
            let opponent2 = Opponent(opponent: team2)

            // Mock Results
            let result1 = Result(score: 16, teamID: 1) // Team Liquid won
            let result2 = Result(score: 14, teamID: 2) // Astralis lost

            // Mock Match
            let mockedMatch = Match(
                beginAt: "2024-09-15T14:00:00Z",  // ISO 8601 format
                league: mockedLeague,
                opponents: [opponent1, opponent2],
                results: [result1, result2],
                status: "finished"
            )
        service.getMatches(completion: { result in
            switch result {
                case .success(let matches):
                    DispatchQueue.main.async {
                        self.matches = [mockedMatch]
                    }

                case  .failure(let error):
                    debugPrint(error)
            }
        })
    }
}
