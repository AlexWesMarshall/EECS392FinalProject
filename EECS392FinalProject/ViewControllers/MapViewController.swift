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
    var timeLeft : Int = 90
    let INIT_TIME : Int = 90
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set the initial start location of the app
        let initialRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.508702, longitude: -81.606348), span: MKCoordinateSpan(latitudeDelta: 0.00001, longitudeDelta: 0.00001))
        mapView.region = initialRegion
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        
        Game.shared.delegate = self
        //Add pins to our points of interest
        var pointsOfInterest = [MKAnnotation]()
        let starbs = MKPointAnnotation()
        starbs.coordinate = PointOfInterest.EuclidStarbucks.coordinate
        pointsOfInterest.append(starbs)
        
        let wade = MKPointAnnotation()
        wade.coordinate = PointOfInterest.Wade.coordinate
        pointsOfInterest.append(wade)
        
        let PBL = MKPointAnnotation()
        PBL.coordinate = PointOfInterest.PBL.coordinate
        pointsOfInterest.append(PBL)
        
        let Sears = MKPointAnnotation()
        Sears.coordinate = PointOfInterest.Sears.coordinate
        pointsOfInterest.append(Sears)
        
        let KSL = MKPointAnnotation()
        KSL.coordinate = PointOfInterest.KSL.coordinate
        pointsOfInterest.append(KSL)
        
        let Veale = MKPointAnnotation()
        Veale.coordinate = PointOfInterest.Veale.coordinate
        pointsOfInterest.append(Veale)
        
        let Village = MKPointAnnotation()
        Village.coordinate = PointOfInterest.Village.coordinate
        pointsOfInterest.append(Village)
        
        let Fribley = MKPointAnnotation()
        Fribley.coordinate = PointOfInterest.Fribley.coordinate
        pointsOfInterest.append(Fribley)
        
        mapView.addAnnotations(pointsOfInterest)
        
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

extension MapViewController: MKMapViewDelegate {
    //Drops a pin on our PointsOfInterest
    func dropPinZoomIn(placemark: MKPlacemark){
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") as? MKPinAnnotationView
        if pinView == nil { pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin") }
        pinView?.canShowCallout = true
        return pinView
    }
    
}

extension MapViewController {
    
    //Sets the amount of coffee the player has
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
    
    //Sets the amount of sleep the player has
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
    
    //Renders the amount of coffee and sleep whenever those fields are updated
    fileprivate func renderGame() {
        coffeeSleepLabel.text = coffeeString() + "\n" + sleepString()
        renderTimeLabel()
    }
    
    //Renders the time left before the homework is due
    fileprivate func renderTimeLabel(){
        if(timer == nil){
            timerLabel.text = "No homework due yet."
        }
        else{
            timerLabel.text = "Due in: \(timeLeft)"
        }
    }
    
    //Called every second after the time is turned on
    //Updates the time left var
    //When time is up, turn off timer and turn in homework
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
    
    //Starts a quest for the player if they currently don't have one
    func startQuest(quest: Quest) {
        if(Game.shared.player?.quest == nil){
            let alert = UIAlertController()
            alert.addAction(UIAlertAction(title: "Accept quest", style: UIAlertAction.Style.default){ [unowned self] _ in
                Game.shared.player?.quest = quest
                self.renderGame()
            })
            alert.addAction(UIAlertAction(title: "Decline quest", style: UIAlertAction.Style.cancel))
            alert.title = quest.description
            present(alert, animated: true)
        }
    }
    
    
    //Ends a quest if the player currently has a quest active
    func endQuest(quest: Quest) {
        if(Game.shared.player?.quest != nil){
            let alert = UIAlertController()
            alert.addAction(UIAlertAction(title: "Leave", style: UIAlertAction.Style.default) { [unowned self] _ in
                Game.shared.player?.quest = nil
                self.applyQuestReward(quest: quest)
            })
            alert.title = quest.completedDescription
            present(alert, animated: true)
        }
    }
    
    //Apply reward to the player
    func applyQuestReward(quest : Quest){
        Game.shared.player?.money += quest.reward
    }
    
    /*
    * Function for turning in homework and giving the player a grade
    * If the timer is done, the player must turn in the homework immediately
    * If Else the player has completed the homework early they can turn it in with extra credit
    * Else the player has not completed the homework but still has time left to finish it
    */
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
    
    //Encounter for buying coffee if the player has enough money
    //If the player does not have enough money, then they can only leave
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
    
    //Notification from Canvas telling the user that have more homework to do
    func canvasNotification(canvasNotification: CanvasNotification) {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Close notification", style: UIAlertAction.Style.default))
        alert.title = "A Canvas notification appeared. You have \(canvasNotification.homework + (Game.shared.player?.homeworkDue)!) new homeworks"
        Game.shared.player?.homeworkDue += canvasNotification.homework
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        present(alert, animated: true)
    }
    
    //Encounter for the player, giving them the chance to study and complete a homework
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
}
