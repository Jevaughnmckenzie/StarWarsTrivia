//
//  Entities.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/25/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import Foundation

protocol SWAPIEntity {
    var name: String? { get }
    var summary: [String]? { get }
}

enum Entity: String {
    case person = "Characters"
    case vehicle = "Vehicles"
    case starship = "Starships"
}






























