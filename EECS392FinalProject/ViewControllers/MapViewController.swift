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
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet weak var heartsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initialRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.508702, longitude: -81.606348),
                                               span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
        mapView.region = initialRegion
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        
        Game.shared.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(gameUpdated(notification:)), name: GameStateNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        renderGame()
    }
    
    @objc func gameUpdated(notification: Notification) {
        renderGame()
    }
}

extension MapViewController {
    
    private func coffeeString() -> String {
        guard let coffee = Game.shared.player?.coffee else { return "☠️" }
        
        let coffeeCount = coffee
        var string = ""
        for _ in 1 ... coffeeCount {
            string += "☕"
        }
        return string
    }
    
    private func sleepString() -> String {
        guard let sleep = Game.shared.player?.sleep else { return "" }
        
        let sleepCount = sleep
        var string = ""
        for _ in 1 ... sleepCount {
            string += "💤"
        }
        return string
    }
    
    fileprivate func renderGame() {
        heartsLabel.text = coffeeString() + "\n" + sleepString()
    }
}

extension MapViewController: GameDelegate {
    
    func canvasNotification(canvasNotification: CanvasNotification) {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Close notification", style: UIAlertAction.Style.default))
        alert.title = "A Canvas notification appeared. You have \(canvasNotification.homework + (Game.shared.player?.homework)!) new homeworks"
        Game.shared.player?.homework += canvasNotification.homework
        for _ in 0..<canvasNotification.homework{
            Game.shared.player?.inventory.append(Textbook.aiTextbook)
        }
        present(alert, animated: true)
    }
    
    func studyEncounter(study : Study) {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Study", style: UIAlertAction.Style.default) { [unowned self] _ in
            if Game.shared.player?.coffee ?? 0 <= 0 {
                Game.shared.player?.sleep -= 1
            }
            else{
                Game.shared.player?.coffee -= 1
            }
            Game.shared.player?.homework -= 1
            self.renderGame()
        })
        alert.addAction(UIAlertAction(title: "Too cool for school 😎", style: UIAlertAction.Style.cancel))
        present(alert, animated: true)
    }
    
    func encounteredTeacher(teacher: Teacher) {
        showFight(teacher: teacher)
    }
    
    func showFight(teacher: Teacher, subtitle: String = "Fight?") {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Run", style: UIAlertAction.Style.cancel) /*{ [unowned self] _ in
            self.showFight(teacher: teacher, subtitle: "I think you should really fight this.")
        }*/)
        
        alert.addAction(UIAlertAction(title: "Fight", style: UIAlertAction.Style.default) { [unowned self] _ in
            guard let result = Game.shared.fight(teacher: teacher) else { return }
            
            switch result {
            case .PlayerLost:
                print("loss!")
            case .PlayerWon:
                print("win!")
            case .Tie:
                self.showFight(teacher: teacher, subtitle: "A good row, but you are both still in the fight!")
            }
        })
        
        //adding an image
        let image = Game.shared.image(for: teacher)
        let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
        imageView.image = image
        alert.view.addSubview(imageView)
        
        alert.title = "A wild \(teacher.name) appeared!"
        present(alert, animated: true) {}
    }
    
    func encounteredDean(dean: Dean) {
        let alert = UIAlertController()
        
        alert.addAction(UIAlertAction(title: "No Thanks", style: UIAlertAction.Style.cancel) {  _ in
            print("done with encounter")
        })
        
        alert.addAction(UIAlertAction(title: "On My Way", style: UIAlertAction.Style.default) {  _ in
            print("did not buy anything")
        })
        
        //adding an image
        let image = Game.shared.image(for: dean)
        let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
        imageView.image = image
        alert.view.addSubview(imageView)
        
        alert.title = dean.name
        present(alert, animated: true)
    }
    /*
    func enteredStore(store: Store) {
        let alert = UIAlertController()
        
        alert.addAction(UIAlertAction(title: "Back Out", style: UIAlertAction.Style.cancel) {  _ in
            print("did not buy anything")
        })
        
        alert.addAction(UIAlertAction(title: "Take My 💰", style: UIAlertAction.Style.default) { [unowned self] _ in
            self.performSegue(withIdentifier: "shop", sender: store)
        })
        
        //adding an image
        let image = Game.shared.image(for: store)
        let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 40, height: 40))
        imageView.image = image
        alert.view.addSubview(imageView)
        
        alert.title = store.name
        present(alert, animated: true)
    } */

}
