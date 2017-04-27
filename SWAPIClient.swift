//
//  SWAPIClient.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import Foundation

struct BaseURL {
    let baseURL = "https://swapi.co"
}

fileprivate struct parameterKeys {
    static let search = "search"
    static let page = "page"
}

enum SWAPI: Endpoint {
    case people(PeopleEndPoint)
    case vehicles(VehicleEndPoint)
    case starships(StarshipEndPoint)
    
    
    
    enum PeopleEndPoint: Endpoint {
        case allPeople(page: Int)
        case search(String?)
    
        
        //MARK: People endpoint
        
        var baseURL: String {
            return BaseURL().baseURL
        }
        
        var path: String {
            return "/api/people/"
        }
        
        var parameters: [String : AnyObject]? {
            switch self {
            case .search(let query):
                if let query = query {
                    return [parameterKeys.search : query as AnyObject]
                }
            case .allPeople(let pageNumber):
                return [parameterKeys.page : pageNumber as AnyObject]
            }
            return nil
        }
    }
    
    enum VehicleEndPoint: Endpoint {
        case allVehicles(page: Int)
        case search(String?)
        
        //MARK: Vehicle endpoint
        
        var baseURL: String {
            return BaseURL().baseURL
        }
        
        var path: String {
            return "/api/vehicles/"
        }
        
        var parameters: [String : AnyObject]? {
            switch self {
            case .search(let query):
                if let query = query {
                    return [parameterKeys.search : query as AnyObject]
                }
            case .allVehicles(let pageNumber):
                return [parameterKeys.page : pageNumber as AnyObject]
            }
            return nil
        }
    }
    
    // MARK: SWAPI Endpoint
    
    enum StarshipEndPoint: Endpoint {
        case allStarships(page: Int)
        case search(String?)
        
        //MARK: Starship endpoint
        
        var baseURL: String {
            return BaseURL().baseURL
        }
        
        var path: String {
            return "/api/starships/"
        }
        
        var parameters: [String : AnyObject]? {
            switch self {
            case .search(let query):
                if let query = query {
                    return [parameterKeys.search : query as AnyObject]
                }
            case .allStarships(let pageNumber):
                return [parameterKeys.page : pageNumber as AnyObject]
            }
            return nil
        }
    }
    
    var baseURL: String {
       return BaseURL().baseURL
    }
    
    var path: String {
        switch self {
        case .people(let peopleQueryType):
            return peopleQueryType.path
        case .vehicles(let vehicleQueryType):
            return vehicleQueryType.path
        case .starships(let starshipQueryType):
            return starshipQueryType.path
        }
    }
    
    var parameters: [String : AnyObject]? {
        
        switch self {
        case .people(let people):
            return people.parameters
        case .vehicles(let vehicles):
            return vehicles.parameters
        case .starships(let starships):
            return starships.parameters
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
    
    func fetchAllPeople(type: SWAPI.PeopleEndPoint, completion: @escaping (APIResult<[Person]>) -> Void) {
     
        
        let endpoint = SWAPI.people(type)
        
        fetch(endpoint, parse: { (json) -> [Person]? in
            guard let allPeople = json["results"] as? [[String : AnyObject]] else {
                return nil
            }
            
            
            return allPeople.flatMap { individualPersonInfo in
                return Person(JSON: individualPersonInfo)
                
            }
            
        }, completion: completion)
        
    }
    
    func fetchAllVehicles(type: SWAPI.VehicleEndPoint, completion: @escaping (APIResult<[Vehicle]>) -> Void) {
        
        
        let endpoint = SWAPI.vehicles(type)
        
        fetch(endpoint, parse: { (json) -> [Vehicle]? in
            guard let allVehicles = json["results"] as? [[String : AnyObject]] else {
                return nil
            }
            
            
            return allVehicles.flatMap { individualVehicleInfo in
                return Vehicle(JSON: individualVehicleInfo)
                
            }
            
        }, completion: completion)
        
    }
    
    func fetchAllStarships(type: SWAPI.StarshipEndPoint, completion: @escaping (APIResult<[Starship]>) -> Void) {
        
        
        let endpoint = SWAPI.starships(type)
        
        fetch(endpoint, parse: { (json) -> [Starship]? in
            guard let allStarships = json["results"] as? [[String : AnyObject]] else {
                return nil
            }
            
            
            return allStarships.flatMap { individualVehicleInfo in
                return Starship(JSON: individualVehicleInfo)
                
            }
            
        }, completion: completion)
        
    }
    
//    func fetchHomeworld() {}
    func fetchVehicles(forPerson person: Person, completion: @escaping (APIResult<Vehicle>) -> Void) {
        var vehicles = [Vehicle]()
        
        guard let ownedVehicles = person.vehicles else {
            return
        }
        for vehicle in ownedVehicles {
            guard let vehicleURL = URL(string: vehicle) else {
                return 
            }
            let vehicleRequest = URLRequest(url: vehicleURL)

            
           fetch(URLrequest: vehicleRequest, parse: { (json) -> Vehicle? in
                let parsedVehicle = Vehicle(JSON: json)
            
            
            return parsedVehicle
          }, completion: completion)
        }
        
       
    }
//    func fetchStarships() {}
    
    
}


















































