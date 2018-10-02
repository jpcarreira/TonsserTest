//
//  TonsserApi.swift
//  Tonsser
//
//  Created by João Carreira on 25/09/2018.
//  Copyright © 2018 jpcarreira. All rights reserved.
//

import Foundation


final class TonsserApi {
    
    private static let baseUrl = "http://staging-api.tonsser.com/49/users/christian-planck/followers"
    
    func getFollowers(for slug: String? = nil, completionHandler: @escaping (Bool, FollowersData?) -> Void) {
        var url: URL
        
        if let slug = slug {
            url = URL(string: "\(TonsserApi.baseUrl)?current_follow_slug=\(slug)")!
        } else {
            url = URL(string: "\(TonsserApi.baseUrl)")!
        }
        
        HTTPClient.get(from: url) { (json, error) in
            if error == nil {
                do {
                    let data = try JSONSerialization.data(withJSONObject: json as Any, options: [])
                    if let string = String(data: data, encoding: String.Encoding.utf8)?.data(using: .utf8) {
                        let followersData = try JSONDecoder().decode(FollowersData.self, from: string)
                        completionHandler(true, followersData)
                    }
                } catch {
                    completionHandler(false, nil)
                }
            }
        }
    }
}
