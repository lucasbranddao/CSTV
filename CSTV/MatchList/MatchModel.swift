//
//  MatchModel.swift
//  CSTV
//
//  Created by Lucas Brandão on 28/08/24.
//

import SwiftUI

enum Status: String {
    case notStarted = "Não iniciado"
    case running = "Agora"
    case finished = "Encerrado"

    var backgroundColor: Color {
        switch self {
            case .notStarted:
                Color(red: 81/255, green: 80/255, blue: 95/255)
            case .running:
                Color(red: 244/255, green: 42/255, blue: 53/255)
            case .finished:
                Color(red: 81/255, green: 80/255, blue: 95/255)
        }
    }

    init?(rawValue: String) {
        switch rawValue {
            case "not_started":
                self = .notStarted
            case "running":
                self = .running
            case "finished":
                self = .finished
            default:
                self = .notStarted
        }
    }
}

typealias Matches = [Match]

struct Match: Hashable {
    static func == (lhs: Match, rhs: Match) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let id = UUID().uuidString
    let leagueAndSerie: String
    let leagueImageUrl: String
    let homeTeam: Team?
    let homeTeamScore: Int
    let awayTeam: Team?
    let awayTeamScore: Int
    let status: Status
    let beginAt: String
    func timeString() -> String {
        switch status {
            case .notStarted:
                return beginAt.formatDate()
            case .running :
                return status.rawValue
            case .finished:
                return status.rawValue
        }
    }
}
