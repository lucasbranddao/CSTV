//
//  MatchModel.swift
//  CSTV
//
//  Created by Lucas Brandão on 27/08/24.
//

import Foundation
import SwiftUI

enum Status: String {
    case notStarted = "Não iniciado"
    case running = "Agora"
    case finished = "Encerrado"

    var backgroundColor: Color {
        switch self {
            case .notStarted:
                Color(red: 250/255, green: 250/255, blue: 250/255)
            case .running:
                Color(red: 244/255, green: 42/255, blue: 53/255)
            case .finished:
                Color(red: 250/255, green: 250/255, blue: 250/255)
        }
    }
}

struct Match2: Hashable {
    static func == (lhs: Match2, rhs: Match2) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let id = UUID().uuidString
    let leagueAndSerie: String
    let homeTeam: Team
    let awayTeam: Team
    let status: Status
}

typealias Matches = [Match]

// MARK: - MatchDetails
struct Match: Codable, Hashable {
    
    let id = UUID().uuidString
    let beginAt: String?
    let league: League
    let opponents: [Opponent]
    let results: [Result]
    let status: String
    let serie: Serie

    enum CodingKeys: String, CodingKey {
        case beginAt = "begin_at"
        case league, opponents, results, status, serie
    }

    static func == (lhs: Match, rhs: Match) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Match {
    func mapLeagueSerie() -> String {
        league.name + " + " + serie.name
    }

    func mapHomeTeam() -> Team? {
        opponents[safe: 0]?.opponent
    }

    func mapAwayTeam() -> Team? {
        opponents[safe: 1]?.opponent
    }
}

// MARK: - League
struct Serie: Codable {
    let name: String
}

// MARK: - League
struct League: Codable {
    let name: String
}

// MARK: - Opponent
struct Opponent: Codable {
    let opponent: Team
}

// MARK: - Team
struct Team: Codable {
    let name: String
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
    }
}

// MARK: - Result
struct Result: Codable {
    let score: Int
    let teamID: Int
    
    enum CodingKeys: String, CodingKey {
        case score
        case teamID = "team_id"
    }
}
