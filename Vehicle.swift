//
//  Vehicles.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import Foundation

struct Vehicle {
    let description = ["Model", "Class", "Manufacturer", "Length", "Cost", "Crew", "Passengers", "Max Atmosphering Speed", "Cargo Capacity", "Consumables", "Pilots"]
    
    let name: String?
    let model: String?
    let vehicleClass: String?
    let manufacturer: String?
    let length: String?
    let costInCredits: String?
    let crew: String?
    let passengers: String?
    let maxAtmospheringSpeed: String?
    let cargoCapacity: String?
    let consumables: String?
    let pilots: [String]?
    
    var summary: [String]?
    var associatedPilots: [String]?
    
    init(name: String, model: String, vehicleClass: String, manufacturer: String, length: String, costInCredits: String, crew: String, passengers: String, maxAtmospheringSpeed: String,
         cargoCapacity: String, consumables: String, pilots: [String]) {
        
        self.name = name
        self.model = model
        self.vehicleClass = vehicleClass
        self.manufacturer = manufacturer
        self.length = length
        self.costInCredits = costInCredits
        self.crew = crew
        self.passengers = passengers
        self.maxAtmospheringSpeed = maxAtmospheringSpeed
        self.cargoCapacity = cargoCapacity
        self.consumables = consumables
        self.pilots = pilots
        
        summary = [model, vehicleClass, manufacturer, length, costInCredits, crew, passengers, maxAtmospheringSpeed, cargoCapacity, consumables]
        associatedPilots = pilots
    }
    
    init() {
        self.name = nil
        self.model = nil
        self.vehicleClass = nil
        self.manufacturer = nil
        self.length = nil
        self.costInCredits = nil
        self.crew = nil
        self.passengers = nil
        self.maxAtmospheringSpeed = nil
        self.cargoCapacity = nil
        self.consumables = nil
        self.pilots = nil
    }
    
}

extension Vehicle: JSONDecodable {
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
            let consumables = JSON["consumables"] as? String else {
            return nil
        }
    
    
        guard let pilots = JSON["pilots"] as? [String] else {
                return nil
        }
        
        self.init(name: name, model: model, vehicleClass: vehicleClass, manufacturer: manufacturer, length: length, costInCredits: costInCredits, crew: crew, passengers: passengers, maxAtmospheringSpeed: maxAtmospheringSpeed, cargoCapacity: cargoCapacity, consumables: consumables, pilots: pilots)
    }
}





















































