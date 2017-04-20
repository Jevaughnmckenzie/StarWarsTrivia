//
//  People.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import Foundation

struct People {
    let name: String
    let birthYear: String
    let eyeColor: String
    let gender: String
    let hairColor: String
    let height: String
    let mass: String
    let skinColor: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let starships: [String]
    let vehicles: [String]
    let url: String
    let created: String
    let edited: String
}

extension People: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let name = JSON["name"] as? String,
            let birthYear = JSON["birth_year"] as? String,
            let eyeColor = JSON["eye_color"] as? String,
            let gender = JSON["gender"] as? String,
            let hairColor = JSON["hair_color"] as? String,
            let height = JSON["height"] as? String,
            let mass = JSON["mass"] as? String,
            let skinColor = JSON["skin_color"] as? String,
            let homeworld = JSON["homeworld"] as? String,
            let url = JSON["url"] as? String,
            let created = JSON["created"] as? String,
            let edited = JSON["edited"] as? String else {
                return nil
        }
        
        
        guard let films = JSON["films"] as? [String],
            let species = JSON["species"] as? [String],
            let starships = JSON["starships"] as? [String],
            let vehicles = JSON["vehicles"] as? [String] else {
                return nil
        }
        
        self.name = name
        self.birthYear = birthYear
        self.eyeColor = eyeColor
        self.gender = gender
        self.hairColor = hairColor
        self.height = height
        self.mass = mass
        self.skinColor = skinColor
        self.homeworld = homeworld
        self.films = films
        self.species = species
        self.starships = starships
        self.vehicles = vehicles
        self.url = url
        self.created = created
        self.edited = edited
    
        
    }
}










































