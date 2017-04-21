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
        case allVehicles
        case search(String?)
        
        //MARK: Vehicle endpoint
        
        var baseURL: String {
            return BaseURL().baseURL
        }
        
        var path: String {
            return "/api/vehicle/"
        }
        
        var parameters: [String : AnyObject]? {
            switch self {
            case .search(let query):
                if let query = query {
                    return [parameterKeys.search : query as AnyObject]
                }
            case .allVehicles:
                return nil
            }
            return nil
        }
    }
    
    // MARK: SWAPI Endpoint
    
    enum StarshipEndPoint: Endpoint {
        case allStarships
        case search(String?)
        
        //MARK: Starship endpoint
        
        var baseURL: String {
            return BaseURL().baseURL
        }
        
        var path: String {
            return "/api/starship/"
        }
        
        var parameters: [String : AnyObject]? {
            switch self {
            case .search(let query):
                if let query = query {
                    return [parameterKeys.search : query as AnyObject]
                }
            case .allStarships:
                return nil
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
    
    func fetchAllPeople(type: SWAPI.PeopleEndPoint, completion: @escaping (APIResult<[People]>) -> Void) {
     
        
        let endpoint = SWAPI.people(type)
        
        fetch(endpoint, parse: { (json) -> [People]? in
            guard let allPeople = json["results"] as? [[String : AnyObject]] else {
                return nil
            }
            
            
            return allPeople.flatMap { peopleList in
                return People(JSON: peopleList)
                
            }
            
        }, completion: completion)
        
    }
    
    
    
}


















































