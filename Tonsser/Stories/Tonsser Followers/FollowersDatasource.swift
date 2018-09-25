//
//  FollowersDatasource.swift
//  Tonsser
//
//  Created by João Carreira on 25/09/2018.
//  Copyright © 2018 jpcarreira. All rights reserved.
//

import Foundation


protocol FollowersDataSourceDelegate: class {
    func dataUpdated()
}


final class FollowersDataSource {
    
    weak var delegate: FollowersDataSourceDelegate?
    
    private var followers = Array<Follower>() 
    
    func numberOfFollowers() -> Int {
        return followers.count
    }
    
    func followerAt(index: Int) -> Follower {
        return followers[index]
    }
    
    func add(followers: [Follower]) {
        self.followers.append(contentsOf: followers)
        delegate?.dataUpdated()
    }
}
