//
//  Vehicles.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import Foundation

struct Vehicles {
    let name: String
    let model: String
    let vehicleClass: String
    let manufacturer: String
    let length: String
    let costInCredits: String
    let crew: String
    let passengers: String
    let maxAtmospheringSpeed: String
    let cargoCapacity: String
    let consumables: String
    let films: [String]
    let pilots: [String]
    let url: String
    let created: String
    let edited: String
}

extension Vehicles: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let name = JSON["name"] as? String,
        let model = JSON["model"] as? String,
        let vehicleClass = JSON["vehicle_class"] as? String,
        let manufacturer = JSON["manufacturer"] as? String,
        let length = JSON["length"] as? String,
        let costInCredits = JSON["cost_in_credits"] as? String,
        let crew = JSON["crew"] as? String,
        let passengers = JSON["passengers"] as? String,
        let maxAtmospheringSpeed = JSON["max_atmosphering_speed"] as? String,
        let cargoCapacity = JSON["cargo_capacity"] as? String,
        let consumables = JSON["consumables"] as? String,
        let url = JSON["url"] as? String,
        let created = JSON["created"] as? String,
            let edited = JSON["editied"] as? String else {
                return nil
        }
        
        guard let films = JSON["films"] as? [String],
            let pilots = JSON["pilots"] as? [String] else {
                return nil
        }
        
        self.name = name
        self.model = model
        self.vehicleClass = vehicleClass
        self.manufacturer = manufacturer
        self.length = length
        self.cargoCapacity = cargoCapacity
        self.costInCredits = costInCredits
        self.crew = crew
        self.passengers = passengers
        self.maxAtmospheringSpeed = maxAtmospheringSpeed
        self.consumables = consumables
        self.films = films
        self.pilots = pilots
        self.url = url
        self.created = created
        self.edited = edited
        
    }
}




















































