//
//  Team.swift
//  Tonsser
//
//  Created by João Carreira on 29/09/2018.
//  Copyright © 2018 jpcarreira. All rights reserved.
//


struct Team: Decodable {
    
    var name: String
    var league: String
    var players: Int
    var logoUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "club_name"
        case leagueName = "league_name"
        case numberOfPlayers = "players_count"
        case club
        case logoUrl = "logo_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        league = try container.decode(String.self, forKey: .leagueName)
        players = try container.decode(Int.self, forKey: .numberOfPlayers)
        let club = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .club)
        logoUrl = try club.decodeIfPresent(String.self, forKey: .logoUrl)
    }
}
