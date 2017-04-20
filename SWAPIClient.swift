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

extension SWAPI: Endpoint {
    var baseURL: String {
       return "https://swapi.co/api/"
    }
    
    var path: String {
        var pathString = ""
        switch self {
        case .people(let peopleQueryType):
            pathString += "people/"
            switch peopleQueryType {
            case .allPeople:
                return pathString
            case .person(let id):
                return "\(pathString)\(id)/"
            case .search(let query):
                return "\(pathString)?search=\(query)"
            }
        case .vehicles(let vehicleQueryType):
            pathString += "vehicles/"
            switch vehicleQueryType {
            case .allVehicles:
                return pathString
            case .vehicle(let id):
                return "\(pathString)\(id)/"
            case .search(let query):
                return "\(pathString)?search=\(query)"
            }
        case .starships(let starshipQueryType):
            pathString += "starships/"
            switch starshipQueryType {
            case .allStarships:
                return pathString
            case .Starships(let id):
                return "\(pathString)\(id)/"
            case .search(let query):
                return "\(pathString)?search=\(query)"
            }
        }
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


















































