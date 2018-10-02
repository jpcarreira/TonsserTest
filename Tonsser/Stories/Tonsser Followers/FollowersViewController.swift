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
    static let reloadDataOffset = 5

    private let api = TonsserApi()
    
    // Rx properties
    let followersDataSource = Variable<[User]>([])
    private var viewedProfiles: Variable<Int> = Variable(0)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinnerCointainerView.isHidden = true
        spinnerCointainerView.layer.cornerRadius = 20
        
        setupViewedProfilesObserver()
        setupDataSourceObserver()
        
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
            
            let model = followersDataSource.value[indexPath.row]
            tonsserProfileViewController.userProfile = model
            tableView.deselectRow(at: indexPath, animated: true)
            
            viewedProfiles.value += 1
        }
    }
    
    private func getFollowers(for slug: String? = nil) {
        toggle(loading: true)
        api.getFollowers(for: slug) { (success, followers) in
            if success {
                self.followersDataSource.value.append(contentsOf: followers!.response)
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
    
    // Rx methods
    private func setupViewedProfilesObserver() {
        viewedProfiles.asObservable()
            .subscribe { value in
                self.viewedProfilesButton.title = "👀 \(value.element ?? 0)"
            }
            .disposed(by: disposeBag)
    }
    
    private func setupDataSourceObserver() {
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        followersDataSource
            .asObservable()
            .bind(to:
                tableView
                    .rx
                    .items(cellIdentifier: FollowerTableViewCell.cellIdentifier)) { row, user, cell in
                        if let cell = cell as? FollowerTableViewCell {
                            cell.decorateCellWith(user: user)
                        }
                    
                        if row == self.followersDataSource.value.count - FollowersViewController.reloadDataOffset {
                            self.getFollowers(for: self.followersDataSource.value[row].slug)
                        }
                    }
            .disposed(by: disposeBag)
    }
}


extension FollowersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FollowerTableViewCell.cellHeight
    }
}
