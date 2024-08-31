//
//  PlayerModel.swift
//  CSTV
//
//  Created by Lucas Brandão on 31/08/24.
//

import Foundation

typealias Players = [PlayerModel]

// MARK: - Team
struct PlayersResponse: Codable {
    let players: [PlayerModel]
}

// MARK: - Player
struct PlayerModel: Codable {
    let firstName: String
    let imageURL: String?
    let lastName: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case imageURL = "image_url"
        case lastName = "last_name"
        case name
    }
}
