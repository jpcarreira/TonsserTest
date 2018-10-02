//
//  User.swift
//  Tonsser
//
//  Created by João Carreira on 25/09/2018.
//  Copyright © 2018 jpcarreira. All rights reserved.
//


protocol FollowerEntityProtocol {
    
    var profilePicture: String? { get }
    var name: String { get }
    var location: String { get }
    var role: String { get }
    var isFollowing: Bool { get }
    var team: Team? { get }
}


struct FollowersData: Decodable {
    
    var response: Array<User>
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        response = try container.decode(Array.self, forKey: .response)
    }
}


struct User: Decodable {
    
    var profilePictureUrl: String?
    var firstName: String
    var lastName: String
    var locationId: Int
    var following: Bool
    var role: String
    var slug: String
    var team: Team?
    
    enum CodingKeys: String, CodingKey {
        case profilePicture = "profile_picture"
        case firstName = "firstname"
        case lastName = "lastname"
        case countryId = "country_id"
        case role
        case isFollowing = "is_following"
        case slug
        case team
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        profilePictureUrl = try container.decodeIfPresent(String.self, forKey: .profilePicture)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        locationId = try container.decode(Int.self, forKey: .countryId)
        role = try container.decode(String.self, forKey: .role)
        following = try container.decode(Bool.self, forKey: .isFollowing)
        slug = try container.decode(String.self, forKey: .slug)
        team = try container.decodeIfPresent(Team.self, forKey: .team)
    }
}


extension User: FollowerEntityProtocol {
    
    var profilePicture: String? {
        return profilePictureUrl ?? nil
    }
    
    var name: String {
        return "\(firstName) \(lastName)"
    }
    
    var location: String {
        // TODO: for simplicity we always return the same string here but this is the place where we could read from a local file or make
        // an API call to translated the countryID into the string that displays the country in a user-friendly way
        return "United Kingdom"
    }
    
    var isFollowing: Bool {
        return following
    }
}
