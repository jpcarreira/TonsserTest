//
//  FollowersDatasource.swift
//  Tonsser
//
//  Created by João Carreira on 25/09/2018.
//  Copyright © 2018 jpcarreira. All rights reserved.
//

import Foundation

struct Follower {
    var profilePictureUrl: String?
    var firstName: String
    var lastName: String
    var locationId: Int
    var isFollowing: Bool
}

final class FollowersDataSource {
    
    private var followers: Array<Follower>
    
    init() {
        // TODO: dummy data
        followers = [
            Follower(profilePictureUrl: "", firstName: "John", lastName: "Doe", locationId: 201, isFollowing: false),
            Follower(profilePictureUrl: "", firstName: "Jane", lastName: "Doe", locationId: 201, isFollowing: false),
            Follower(profilePictureUrl: "", firstName: "John", lastName: "Appleseed", locationId: 201, isFollowing: true)
        ]
    }
    
    func numberOfFollowers() -> Int {
        return followers.count
    }
    
    func followerAt(index: Int) -> Follower {
        return followers[index]
    }
}
