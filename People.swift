//
//  People.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import Foundation
import UIKit

class People: NSObject, JSONDecodable, UITableViewDelegate, UITableViewDataSource {
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
    
    var summary: [String]
    var associatedVehicles: [[String]]
    
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
        
        super.init()
    }
    
    // MARK: - JSON Parsing
    
    convenience required init?(JSON: [String : AnyObject]) {
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summary.count + associatedVehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nameCell = tableView.dequeueReusableCell(withIdentifier: "name")!
        
        return nameCell
    }
    
    
}

class TableCell: UITableViewCell {
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
//        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setupViews() {
//        addSubview(titleLabel)
//        addSubview(descriptionLabel)
//        
//        let views = [
//            "title" : titleLabel,
//            "description" : descriptionLabel
//        ]
    
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[title]-20-[description]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[description]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
//    }
    
}











































