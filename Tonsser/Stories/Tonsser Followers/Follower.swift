//
//  Follower.swift
//  Tonsser
//
//  Created by João Carreira on 25/09/2018.
//  Copyright © 2018 jpcarreira. All rights reserved.
//

import Foundation


protocol FollowerEntityProtocol {
    
    var profilePicture: String? { get }
    var name: String { get }
    var location: String { get }
    var role: String { get }
    var isFollowing: Bool { get }
}


struct FollowersData: Decodable {
    
    var response: Array<Follower>
    
    enum CodingKeys: String, CodingKey {
        case response
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        response = try container.decode(Array.self, forKey: .response)
    }
}


struct Follower: Decodable {
    
    var profilePictureUrl: String?
    var firstName: String
    var lastName: String
    var locationId: Int
    var following: Bool
    var role: String
    var slug: String
    
    enum CodingKeys: String, CodingKey {
        case profilePicture = "profile_picture"
        case firstName = "firstname"
        case lastName = "lastname"
        case countryId = "country_id"
        case role
        case isFollowing = "is_following"
        case slug
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
    }
    
}


extension Follower: FollowerEntityProtocol {
    
    var profilePicture: String? {
        return profilePictureUrl ?? nil
    }
    
    var name: String {
        return "\(firstName) \(lastName)"
    }
    
    var location: String {
        // TODO:
        return "London, UK"
    }
    
    var isFollowing: Bool {
        return following
    }
}
