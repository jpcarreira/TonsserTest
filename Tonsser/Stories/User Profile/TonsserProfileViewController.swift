//
//  TonsserProfileViewController.swift
//  Tonsser
//
//  Created by João Carreira on 27/09/2018.
//  Copyright © 2018 jpcarreira. All rights reserved.
//

import UIKit
import Kingfisher


final class TonsserProfileViewController: UIViewController {
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var playersLabel: UILabel!
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    var userProfile: FollowerEntityProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        decorateView()
    }
    
    private func setupView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    
    private func decorateView() {
        if let image = userProfile?.profilePicture {
            profileImageView.kf.setImage(with: URL(string: image))
        }
        nameLabel.text = userProfile?.name
        roleLabel.text = userProfile?.role
        locationLabel.text = userProfile?.location
        
        if let logo = userProfile?.team?.logoUrl {
            teamImageView.kf.setImage(with: URL(string: logo))
        }
        teamNameLabel.text = userProfile?.team?.name
        playersLabel.text = "\(userProfile?.team?.players ?? 0) players"
        leagueNameLabel.text = userProfile?.team?.league
    }
}
