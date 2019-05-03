//
//  AppDelegate.swift
//  EECS392FinalProject
//
//  Created by Alexander Marshall on 4/24/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties
    var window: UIWindow?
    let locationListener = LocationListener()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Game.shared.player = Player(name: "Frankum", homeworkGiven: 0, grade: 85, coffee: 1, sleep: 3, money : 0)
        return true
    }
}

