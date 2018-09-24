//
//  FollowerTableViewCell.swift
//  Tonsser
//
//  Created by João Carreira on 24/09/2018.
//  Copyright © 2018 jpcarreira. All rights reserved.
//

import UIKit


final class FollowerTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "FollowerCell"
    static let cellHeight: CGFloat = 68.0
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var followerImageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func actionButtonWasPressed(_ sender: UIButton) {
        // TODO:
        print("Did press action button")
    }
}
