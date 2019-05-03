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
    @IBOutlet weak var homeworkDueLabel: UILabel!
    @IBOutlet weak var homeworkFinishedLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var questLabel: UILabel!
    @IBOutlet weak var homeworkTimerLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        avatarImageView.image = UIImage(named: "Player")
        nameLabel.text = Game.shared.player?.name
        homeworkDueLabel.text = "Homework Assignments Due: \(Game.shared.player?.homeworkDue ?? 0)"
        homeworkFinishedLabel.text = "Homework Assignments Finished: \(Game.shared.player?.homeworkComplete ?? 0)"
        moneyLabel.text = "Money: \(Game.shared.player?.money ?? 0)"
        gradeLabel.text = "Grade = \(Game.shared.player?.grade ?? 70)"
    }
}


