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
    @IBOutlet weak var coffeeSleepLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    var timer : Timer?
    var timeLeft : Int = 80
    let INIT_TIME : Int = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initialRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.508702, longitude: -81.606348), span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
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
        if(coffee == 0){ return "" }
        let coffeeCount = coffee
        var string = ""
        for _ in 1 ... coffeeCount {
            string += "☕"
        }
        return string
    }
    
    private func sleepString() -> String {
        guard let sleep = Game.shared.player?.sleep else { return "" }
        if(sleep == 0){ return "" }
        let sleepCount = sleep
        var string = ""
        for _ in 1 ... sleepCount {
            string += "💤"
        }
        return string
    }
    
    fileprivate func renderGame() {
        coffeeSleepLabel.text = coffeeString() + "\n" + sleepString()
        renderTimeLabel()
    }
    
    fileprivate func renderTimeLabel(){
        if(timer == nil){
            timerLabel.text = "No homework due yet."
        }
        else{
            timerLabel.text = "Due in: \(timeLeft)"
        }
    }
    
    @objc func onTimerFires(){
        timeLeft -= 1
        
        if timeLeft <= 0{
            timer?.invalidate()
            timer = nil
            timeLeft = INIT_TIME
            turnInHomework()
        }
        renderTimeLabel()
    }
}

extension MapViewController: GameDelegate {
    
    func turnInHomework(){
        let alert = UIAlertController()
        if(timer == nil){
            Game.shared.player?.grade = Double.random(in: 60..<80)
            alert.addAction(UIAlertAction(title: "Times up! Turn in homework.", style: UIAlertAction.Style.default))
            Game.shared.player?.homeworkDue = 0
            Game.shared.player?.homeworkComplete = 0
        }
        else if (Game.shared.player?.homeworkDue ?? 1 <= 0) {
            Game.shared.player?.grade = Double.random(in: 70..<80) + Double.random(in: 1..<20)
            alert.addAction(UIAlertAction(title: "Turn in homework early.", style: UIAlertAction.Style.default))
            alert.addAction(UIAlertAction(title: "I need more time!", style: UIAlertAction.Style.cancel))
            timer?.invalidate()
            timer = nil
            timeLeft = INIT_TIME
            Game.shared.player?.homeworkDue = 0
            Game.shared.player?.homeworkComplete = 0
        }
        else{
            alert.addAction(UIAlertAction(title: "Leave", style: UIAlertAction.Style.default))
            alert.title = "I still need to finish my work 😟"
        }
        renderGame()
        present(alert, animated: true)
    }
    
    func coffeeEncounter(coffeeShop: Starbucks, title : String?) {
        let alert = UIAlertController()
        if(title != nil){
            alert.title = title
        }
        else{
            alert.addAction(UIAlertAction(title: "Buy coffee for \(coffeeShop.coffeePrice)?", style : UIAlertAction.Style.default){ [unowned self] _ in
                if(Game.shared.player?.money ?? 0 < coffeeShop.coffeePrice){
                    self.coffeeEncounter(coffeeShop: coffeeShop, title : "I don't have enough money to buy coffee")
                }
                else{
                    Game.shared.player?.money -= coffeeShop.coffeePrice
                    Game.shared.player?.coffee += 1
                    self.renderGame()
                }})
        }
        alert.addAction(UIAlertAction(title: "Leave", style: UIAlertAction.Style.cancel))
        present(alert, animated: true)
    }
    
    func canvasNotification(canvasNotification: CanvasNotification) {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Close notification", style: UIAlertAction.Style.default))
        alert.title = "A Canvas notification appeared. You have \(canvasNotification.homework + (Game.shared.player?.homeworkDue)!) new homeworks"
        Game.shared.player?.homeworkDue += canvasNotification.homework
        for _ in 0..<canvasNotification.homework{
            Game.shared.player?.inventory.append(Textbook.aiTextbook)
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
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
            Game.shared.player?.homeworkDue -= 1
            Game.shared.player?.homeworkComplete += 1
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
        alert.addAction(UIAlertAction(title: "Run", style: UIAlertAction.Style.cancel))
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
}
