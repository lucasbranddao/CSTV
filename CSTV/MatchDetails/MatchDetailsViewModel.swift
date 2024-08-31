//
//  MatchDetailsViewModel.swift
//  CSTV
//
//  Created by Lucas Brandão on 31/08/24.
//

import Foundation
import Combine

protocol MatchDetailsViewModelProtocol: ObservableObject {
    func fetchPlayers()
    var players: [Players] { get set }
}

final class MatchDetailsViewModel: MatchDetailsViewModelProtocol {
    private let service: MatchDetailsService
    var cancellables = Set<AnyCancellable>()
    @Published var players: [Players] = []

    init(service: MatchDetailsService) {
        self.service = service
    }

    func fetchPlayers() {
        let firstRequest = service.getPlayersPublisher()
        let secondRequest = service.getPlayersPublisher()

        Publishers.Zip(firstRequest, secondRequest)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        print("Both requests finished.")
                    case .failure(let error):
                        debugPrint("Error: \(error)")
                }
            }, receiveValue: { homePlayers, awayPlayers in
                self.players = [homePlayers, awayPlayers]
            })
            .store(in: &cancellables)
    }
}
