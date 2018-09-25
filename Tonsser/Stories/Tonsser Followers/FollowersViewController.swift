//
//  FollowersViewController.swift
//  Tonsser
//
//  Created by João Carreira on 24/09/2018.
//  Copyright © 2018 jpcarreira. All rights reserved.
//

import UIKit


final class FollowersViewController: UITableViewController {
    
    private var datasource = FollowersDataSource()
    private let api = TonsserApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datasource.delegate = self
        
        api.getFollowers { (success, followers) in
            self.datasource.add(followers: (followers?.response)!)
        }
        
        tableView.allowsSelection = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.numberOfFollowers()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowerTableViewCell.cellIdentifier, for: indexPath) as! FollowerTableViewCell
        cell.decorateCellWith(follower: datasource.followerAt(index: indexPath.row))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FollowerTableViewCell.cellHeight
    }
}


extension FollowersViewController: FollowersDataSourceDelegate {
    
    func dataUpdated() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
