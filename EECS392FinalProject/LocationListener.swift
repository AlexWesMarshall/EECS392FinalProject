//
//  LocationListener.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/25/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation
import CoreLocation

class LocationListener: NSObject {
    
    // MARK: - Properties
    let manager = CLLocationManager()
    
    // MARK: - Initializers
    override init() {
        super.init()
        
        manager.delegate = self
        manager.activityType = .other
        manager.requestWhenInUseAuthorization()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationListener: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.last != nil else { return }
        
        //Game.shared.visitedLocation(location: lastLocation)
    }
}
