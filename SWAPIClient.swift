//
//  SWAPIClient.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import Foundation

enum SWAPI {
    case people(PeopleEndPoint)
    case vehicles(VehicleEndPoint)
    case starships(StarshipEndPoint)
    
    enum PeopleEndPoint {
        case allPeople
        case search(String)
        case person(Int)
        
    }
    
    enum VehicleEndPoint {
        case allVehicles
        case search(String)
        case vehicle(Int)
    }
    
    enum StarshipEndPoint {
        case allStarships
        case search(String)
        case Starships(Int)
    }
}

final class SWAPIClient: APIClient {
    var configuration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    init(configuration: URLSessionConfiguration) {
        self.configuration = configuration
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    
    
}


















































