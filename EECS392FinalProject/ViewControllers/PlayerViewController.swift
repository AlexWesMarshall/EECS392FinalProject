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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        avatarImageView.image = #imageLiteral(resourceName: "adventurer")
    }
}

extension PlayerViewController: UICollectionViewDataSource {
    
    var inventory: [Item] { return Game.shared.player?.inventory ?? [] }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inventory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let imageView = cell.viewWithTag(1) as! UIImageView
        let label = cell.viewWithTag(2) as! UILabel
        
        let item = inventory[indexPath.row]
        imageView.image = Game.shared.image(for: item)
        
        label.text = ""
        if let textbook = item as? Textbook {
            label.text = "+\(textbook.gradeBoost)"
        }
        
        cell.layer.cornerRadius = 8
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }
}

