//
//  Starships.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import Foundation

struct Starship: SWAPIEntity {
    let description = ["Model", "Starship Class", "Manufacturer", "Length", "Cargo Capacity", "Cost", "Crew", "Passengers", "Max Speed", "Hyperdrive Rating", "MGLT", "Consumables", "Pilots"]
    
    let name: String?
    let model: String?
    let starshipClass: String?
    let manufacturer: String?
    let length: String?
    let costInCredits: String?
    let crew: String?
    let passengers: String?
    let maxAtmospheringSpeed: String?
    let hyperdriveRating: String?
    let MGLT: String?
    let cargoCapacity: String?
    let consumables: String?
    let pilots: [String]?
    
    var summary: [String]?
    var associatedPilots: [String]?
    
    init(name: String, model: String, starshipClass: String, manufacturer: String, length: String, costInCredits: String, crew: String, passengers: String, maxAtmospheringSpeed: String, hyperdriveRating: String, MGLT: String, cargoCapacity: String, consumables: String, pilots: [String]) {
        
        self.name = name
        self.model = model
        self.starshipClass = starshipClass
        self.manufacturer = manufacturer
        self.length = length
        self.cargoCapacity = cargoCapacity
        self.costInCredits = costInCredits
        self.crew = crew
        self.passengers = passengers
        self.maxAtmospheringSpeed = maxAtmospheringSpeed
        self.hyperdriveRating = hyperdriveRating
        self.MGLT = MGLT
        self.consumables = consumables
        self.pilots = pilots
        
        summary = [model, starshipClass, manufacturer, length, cargoCapacity, costInCredits, crew, passengers, maxAtmospheringSpeed, hyperdriveRating, MGLT, consumables]
        
    }
    
    init() {
        self.name = nil
        self.model = nil
        self.starshipClass = nil
        self.manufacturer = nil
        self.length = nil
        self.cargoCapacity = nil
        self.costInCredits = nil
        self.crew = nil
        self.passengers = nil
        self.maxAtmospheringSpeed = nil
        self.hyperdriveRating = nil
        self.MGLT = nil
        self.consumables = nil
        self.pilots = nil
    }

    
}

extension Starship: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let name = JSON["name"] as? String,
            let model = JSON["model"] as? String,
            let starshipClass = JSON["starship_class"] as? String,
            let manufacturer = JSON["manufacturer"] as? String,
            let length = JSON["length"] as? String,
            let costInCredits = JSON["cost_in_credits"] as? String,
            let crew = JSON["crew"] as? String,
            let passengers = JSON["passengers"] as? String,
            let maxAtmospheringSpeed = JSON["max_atmosphering_speed"] as? String,
            let hyperdriveRating = JSON["hyperdrive_rating"] as? String,
            let MGLT = JSON["MGLT"] as? String,
            let cargoCapacity = JSON["cargo_capacity"] as? String,
            let consumables = JSON["consumables"] as? String else {
                return nil
        }
        
        guard let pilots = JSON["pilots"] as? [String] else {
                return nil
        }
        
        

        self.init(name: name, model: model, starshipClass: starshipClass, manufacturer: manufacturer, length: length, costInCredits: costInCredits, crew: crew, passengers: passengers, maxAtmospheringSpeed: maxAtmospheringSpeed, hyperdriveRating: hyperdriveRating, MGLT: MGLT, cargoCapacity: cargoCapacity, consumables: consumables, pilots: pilots)
        
    }
}

























































