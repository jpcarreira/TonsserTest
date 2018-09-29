//
//  FollowersViewController.swift
//  Tonsser
//
//  Created by João Carreira on 24/09/2018.
//  Copyright © 2018 jpcarreira. All rights reserved.
//

import UIKit


final class FollowersViewController: UITableViewController {
    
    static let followerDetailSegueIdentifier = "FollowerDetail"
    
    private var datasource = FollowersDataSource()
    private let api = TonsserApi()
    private var activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.activityIndicatorViewStyle = .whiteLarge
        activityIndicatorView.backgroundColor = .black
        activityIndicatorView.alpha = 0.8
        activityIndicatorView.layer.cornerRadius = 12
        view.addSubview(activityIndicatorView)
        datasource.delegate = self
        
        getFollowers()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.numberOfFollowers
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowerTableViewCell.cellIdentifier, for: indexPath) as! FollowerTableViewCell
        cell.decorateCellWith(follower: datasource.followerAt(index: indexPath.row))
        
        if let lastSlug = datasource.lastSlug, indexPath.row == datasource.offsetToLoadMore - 1 {
            getFollowers(for: lastSlug)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FollowerTableViewCell.cellHeight
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == FollowersViewController.followerDetailSegueIdentifier {
            guard let cell = sender as? FollowerTableViewCell else {
                return
            }
            
            let indexPath = tableView.indexPath(for: cell)
            let model = datasource.followerAt(index: (indexPath?.row)!)
            
            guard let tonsserProfileViewController = segue.destination as? TonsserProfileViewController else {
                return
            }
            tonsserProfileViewController.userProfile = model
        }
    }
    
    private func getFollowers(for slug: String? = nil) {
        toggle(loading: true)
        api.getFollowers(for: slug) { (success, followers) in
            if success {
                self.datasource.add(followers: (followers?.response)!)
            }
            DispatchQueue.main.async {
                self.toggle()
            }
        }
    }
    
    private func toggle(loading: Bool = false) {
        tableView.isScrollEnabled = !loading
        if loading {
            activityIndicatorView.center = CGPoint(x: tableView.bounds.midX, y: tableView.bounds.midY)
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}


extension FollowersViewController: FollowersDataSourceDelegate {
    
    func dataUpdated() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
