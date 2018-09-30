//
//  FollowersViewController.swift
//  Tonsser
//
//  Created by João Carreira on 24/09/2018.
//  Copyright © 2018 jpcarreira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


final class FollowersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinnerCointainerView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var viewedProfilesButton: UIBarButtonItem!
    
    static let followerDetailSegueIdentifier = "FollowerDetail"
    private var followersDataSource = Array<User>() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let api = TonsserApi()
    
    private var viewedProfiles: Variable<Int> = Variable(0)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinnerCointainerView.isHidden = true
        spinnerCointainerView.layer.cornerRadius = 20
        
        setupViewedProfilesObserver()
        getFollowers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == FollowersViewController.followerDetailSegueIdentifier {
            guard
                let cell = sender as? FollowerTableViewCell,
                let indexPath = tableView.indexPath(for: cell),
                let tonsserProfileViewController = segue.destination as? TonsserProfileViewController else {
                    return
            }
            
            let model = followersDataSource[indexPath.row]
            tonsserProfileViewController.userProfile = model
            tableView.deselectRow(at: indexPath, animated: true)
            
            viewedProfiles.value += 1
        }
    }
    
    private func getFollowers(for slug: String? = nil) {
        toggle(loading: true)
        api.getFollowers(for: slug) { (success, followers) in
            if success {
                self.followersDataSource.append(contentsOf: followers!.response)
            }
            DispatchQueue.main.async {
                self.toggle()
            }
        }
    }
    
    private func toggle(loading: Bool = false) {
        tableView.isScrollEnabled = !loading
        spinnerCointainerView.isHidden = !loading
        if loading {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
    
    private func setupViewedProfilesObserver() {
        viewedProfiles.asObservable()
            .subscribe { value in
                self.viewedProfilesButton.title = "👀 \(value.element ?? 0)"
            }
            .disposed(by: disposeBag)
    }
}


extension FollowersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followersDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowerTableViewCell.cellIdentifier, for: indexPath) as! FollowerTableViewCell
        cell.decorateCellWith(user: followersDataSource[indexPath.row])
        
        if let lastSlug = followersDataSource.last?.slug, indexPath.row == followersDataSource.count - 5 - 1 {
            getFollowers(for: lastSlug)
        }
        
        return cell
    }
}


extension FollowersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FollowerTableViewCell.cellHeight
    }
}
