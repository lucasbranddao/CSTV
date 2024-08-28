//
//  MatchModel.swift
//  CSTV
//
//  Created by Lucas Brandão on 27/08/24.
//

import Foundation

typealias Matches = [Match]

// MARK: - MatchDetails
struct Match: Codable, Hashable {
    
    let id = UUID().uuidString
    let beginAt: String?
    let league: League
    let opponents: [Opponent]
    let results: [Result]
    let status: String

    enum CodingKeys: String, CodingKey {
        case beginAt = "begin_at"
        case league, opponents, results, status
    }

    static func == (lhs: Match, rhs: Match) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
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
