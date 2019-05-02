//
//  Starbucks.swift
//  EECS392FinalProject
//
//  Created by Alexander Marshall on 5/2/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation


class Starbucks {
    var name : String
    var coffeePrice : Int
    
    init(name : String, coffeePrice : Int){
        self.name = name
        self.coffeePrice = coffeePrice
    }
}

extension Starbucks {
    static let EuclidStarbucks = Starbucks(name: "Euclid", coffeePrice: Int.random(in: 1..<6))
}
