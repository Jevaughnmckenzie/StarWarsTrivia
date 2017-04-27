//
//  People.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import Foundation
import UIKit

struct Person: JSONDecodable {
    
    var description: [String] = ["Birth Year", "Eye Color", "Gender", "Hair Color", "Height", "Mass", "Skin Color"]
    
    var name: String?
    var birthYear: String?
    var eyeColor: String?
    var gender: String?
    var hairColor: String?
    var height: String?
    var mass: String?
    var skinColor: String?
    var homeworld: String?
    var starships: [String]?
    var vehicles: [String]?
    
    var summary: [String]?
    var associatedVehicles: [[String]]?
    
    init(name: String, birthYear: String, eyeColor: String, gender: String, hairColor: String, height: String, mass: String, skinColor: String, homeworld: String, starships: [String], vehicles: [String]) {
        
        self.name = name
        self.birthYear = birthYear
        self.eyeColor = eyeColor
        self.gender = gender
        self.hairColor = hairColor
        self.height = height
        self.mass = mass
        self.skinColor = skinColor
        self.homeworld = homeworld
        self.starships = starships
        self.vehicles = vehicles
        
        
        
        summary = [birthYear, eyeColor, gender, hairColor, height, mass, skinColor]
        associatedVehicles = [starships, vehicles]
        
    }
    
    init(){
        self.name = nil
        self.birthYear = nil
        self.eyeColor = nil
        self.gender = nil
        self.hairColor = nil
        self.height = nil
        self.mass = nil
        self.skinColor = nil
        self.homeworld = nil
        self.starships = nil
        self.vehicles = nil
    }
    
    // MARK: - JSON Parsing
    
    init?(JSON: [String : AnyObject]) {
        
        guard let name = JSON["name"] as? String,
            let birthYear = JSON["birth_year"] as? String,
            let eyeColor = JSON["eye_color"] as? String,
            let gender = JSON["gender"] as? String,
            let hairColor = JSON["hair_color"] as? String,
            let height = JSON["height"] as? String,
            let mass = JSON["mass"] as? String,
            let skinColor = JSON["skin_color"] as? String,
            let homeworld = JSON["homeworld"] as? String else {
                return nil
        }
        
        
        guard let starships = (JSON["starships"] as? [String])?.joined(separator: ", "),
            let vehicles = (JSON["vehicles"] as? [String])?.joined(separator: ", ") else {
                return nil
        }
        
        self.init(name: name, birthYear: birthYear, eyeColor: eyeColor, gender: gender, hairColor: hairColor, height: height, mass: mass, skinColor: skinColor, homeworld: homeworld, starships: [starships], vehicles: [vehicles])
        
    }

    // MARK: - TableView
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return summary.count + associatedVehicles.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let nameCell = tableView.dequeueReusableCell(withIdentifier: "name")!
//        
//        return nameCell
//    }
    
    
}













































