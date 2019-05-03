//
//  Encounter.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 5/1/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//
//Specifies what is an encounter
//For more types of encounters, add an extension here

import Foundation

protocol Encounter {
}

extension CanvasNotification : Encounter{
}

extension Study : Encounter{
}

extension Starbucks : Encounter{
}

extension Homework : Encounter{
}

extension Quest : Encounter{
}
