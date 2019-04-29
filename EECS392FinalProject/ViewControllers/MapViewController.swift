//
//  MapViewController.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/25/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initialRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.774669555422349, longitude: -73.964170794293238),
                                               span: MKCoordinateSpan(latitudeDelta: 0.16405544070813249, longitudeDelta: 0.1232528799585566))
        mapView.region = initialRegion
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        
        //Game.shared.delegate = self
        
        //NotificationCenter.default.addObserver(self, selector: #selector(gameUpdated(notification:)), name: GameStateNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        renderGame()
    }
    
    func setupTileRenderer() {
        // Add code here
    }
    
    func setupLakeOverlay() {
        // Add code here
    }
    
    @objc func gameUpdated(notification: Notification) {
        renderGame()
    }
}

// MARK: - MapView Delegate
extension MapViewController: MKMapViewDelegate {
    // Add mapview delegate code here
    
}

// MARK: - Game Delegate
extension MapViewController: GameDelegate {
    
    func encounteredMonster(monster: Teacher) {
        showFight(monster: monster)
    }
    
    func showFight(monster: Teacher, subtitle: String = "Fight?") {
        let alert = UIAlertController()
        
        alert.addAction(action: AABlurAlertAction(title: "Run", style: UIAlertActionStyle.cancel) { [unowned self] _ in
            self.showFight(monster: monster, subtitle: "I think you should really fight this.")
        })
        
        alert.addAction(action: AABlurAlertAction(title: "Fight", style: UIAlertActionStyle.default) { [unowned self] _ in
            guard let result = Game.shared.fight(monster: monster) else { return }
            
            switch result {
            case .HeroLost:
                print("loss!")
            case .HeroWon:
                print("win!")
            case .Tie:
                self.showFight(monster: monster, subtitle: "A good row, but you are both still in the fight!")
            }
        })
        
        alert.blurEffectStyle = .regular
        
        let image = Game.shared.image(for: monster)
        alert.alertImage.image = image
        alert.alertTitle.text = "A wild \(monster.name) appeared!"
        alert.alertSubtitle.text = subtitle
        present(alert, animated: true) {}
    }
    
    func encounteredNPC(npc: NPC) {
        let alert = AABlurAlertController()
        
        alert.addAction(action: AABlurAlertAction(title: "No Thanks", style: AABlurActionStyle.cancel) {  _ in
            print("done with encounter")
        })
        
        alert.addAction(action: AABlurAlertAction(title: "On My Way", style: AABlurActionStyle.default) {  _ in
            print("did not buy anything")
        })
        
        alert.blurEffectStyle = .regular
        
        let image = Game.shared.image(for: npc)
        alert.alertImage.image = image
        alert.alertTitle.text = npc.name
        alert.alertSubtitle.text = npc.quest
        present(alert, animated: true)
    }
    
    func enteredStore(store: Store) {
        let alert = AABlurAlertController()
        
        alert.addAction(action: AABlurAlertAction(title: "Back Out", style: AABlurActionStyle.cancel) {  _ in
            print("did not buy anything")
        })
        
        alert.addAction(action: AABlurAlertAction(title: "Take My 💰", style: AABlurActionStyle.default) { [unowned self] _ in
            self.performSegue(withIdentifier: "shop", sender: store)
        })
        
        alert.blurEffectStyle = .regular
        
        let image = Game.shared.image(for: store)
        alert.alertImage.image = image
        alert.alertTitle.text = store.name
        alert.alertSubtitle.text = "Shopping for accessories?"
        present(alert, animated: true)
    }

}
