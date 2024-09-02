//
//  MatchResponse.swift
//  CSTV
//
//  Created by Lucas Brandão on 27/08/24.
//

import Foundation

typealias MatchesResponse = [MatchResponse]

// MARK: - MatchDetails
struct MatchResponse: Codable {

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
}

// MARK: - League
struct Serie: Codable {
    let name: String
}

// MARK: - League
struct League: Codable {
    let name: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
    }
}

// MARK: - Opponent
struct Opponent: Codable {
    let opponent: Team
}

// MARK: - Team
struct Team: Codable {
    let name: String
    let imageURL: String?
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name, id
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
