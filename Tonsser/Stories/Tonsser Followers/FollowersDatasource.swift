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
    
    private var followers = Array<User>()
    
    var numberOfFollowers: Int {
        return followers.count
    }
    
    var offsetToLoadMore: Int {
        return followers.count - 5
    }
    
    var lastSlug: String? {
        return followers.last?.slug
    }
    
    func user(at index: Int) -> User {
        return followers[index]
    }
    
    func add(users: [User]) {
        self.followers.append(contentsOf: users)
        delegate?.dataUpdated()
    }
}
