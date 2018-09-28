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
        profileImageView.kf.setImage(with: URL(string: (userProfile?.profilePicture)!))
        nameLabel.text = userProfile?.name
        roleLabel.text = userProfile?.role
        locationLabel.text = userProfile?.location
    }
}
