//
//  FollowerTableViewCell.swift
//  Tonsser
//
//  Created by João Carreira on 24/09/2018.
//  Copyright © 2018 jpcarreira. All rights reserved.
//

import UIKit
import Kingfisher


final class FollowerTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "FollowerCell"
    static let cellHeight: CGFloat = 68.0
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var followerImageView: UIImageView!
    
    func decorateCellWith(user: User) {
        nameLabel.text = "\(user.firstName) \(user.lastName)"
        locationLabel.text = "\(user.locationId)"
        
        if let imageProfileUrl = user.profilePictureUrl {
            followerImageView.kf.setImage(with: URL(string: imageProfileUrl))
        } else {
            followerImageView.image = UIImage(named: "placeholder")
        }
    }
}
