//
//  PlayerViewController.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/25/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var homeworkLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avatarImageView.image = UIImage(named: "Player")
        nameLabel.text = Game.shared.player?.name
        homeworkLabel.text = "Homework Assignments Due: \(Game.shared.player?.homework ?? 0)"
    }
}


