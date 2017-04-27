//
//  MasterViewController.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import UIKit

class ResourceController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var entityName: UILabel!
    @IBOutlet weak var moreInfoSelector: UIPickerView!
    @IBOutlet weak var moreInfoTableView: UITableView!
    
    let swapiClient = SWAPIClient()
    var selectedEntity: String?
   
    // MARK: Pickerwheel Data
    var people: [Person] = [] {
        didSet {
            moreInfoSelector.reloadAllComponents()
            moreInfoSelector.selectRow(0, inComponent: 0, animated: false)
        }
    }
    var vehicles: [Vehicle] = [] {
        didSet {
            moreInfoSelector.reloadAllComponents()
        }
    }

    var starships: [Starship] = [] {
        didSet {
            moreInfoSelector.reloadAllComponents()
        }
    }

    var currentSelection: String = ""
    
    // MARK: - TableView Data
    var personInfo: [String] = [] {
        didSet {
           moreInfoTableView.reloadData()
        }
    }

    var vehicleInfo: [String] = [] {
        didSet {
            moreInfoTableView.reloadData()
        }
    }
    
    var starshipInfo: [String] = [] {
        didSet {
            moreInfoTableView.reloadData()
        }
    }
    
//    var personOwnedVehicle: String = {
//        
//    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        changeNavBarTitle()
        
//        moreInfoTableView.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableViewDesign()
        moreInfoTableView.register(InfoCell.self, forCellReuseIdentifier: "swapiCell")
        
        moreInfoSelector.delegate = self
        moreInfoSelector.dataSource = self
        moreInfoTableView.delegate = self
        moreInfoTableView.dataSource = self
        
        moreInfoTableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        switch Entity(rawValue: selectedEntity!)! {
        case .person:
            showAllPeople()
        case .vehicle:
            showAllVehicles()
        case .starship:
            showAllStarships()
        }
        
    }
    
    override func viewWillLayoutSubviews() {

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Programatic Views
    
    func setUpTableView() {
       
    }
    
    
    
    
    
    // MARK: - Updating PickerView lists
    
    func showAllPeople() {
        var pageNumber = 1
        repeat {
            swapiClient.fetchAllPeople(type: .allPeople(page: pageNumber)) { (result) in
                switch result {
                case .success(let people):
                    self.people.append(contentsOf: people)
                case .failure(let error):
                    print(error) //FIXME: handle error properly
                }
            }
             pageNumber += 1
            
        } while pageNumber < 10 // FIXME: get rid of magic number
        
    }
    
    func showAllVehicles() {
        var pageNumber = 1
        repeat {
            swapiClient.fetchAllVehicles(type: .allVehicles(page: pageNumber)) { (result) in
                switch result {
                case .success(let vehicle):
                    self.vehicles.append(contentsOf: vehicle)
                case .failure(let error):
                    print(error) //FIXME: handle error properly
                }
            }
            pageNumber += 1
            
        } while pageNumber < 5 // FIXME: get rid of magic number
        
    }
    
    func showAllStarships() {
        var pageNumber = 1
        repeat {
            swapiClient.fetchAllStarships(type: .allStarships(page: pageNumber)) { (result) in
                switch result {
                case .success(let starships):
                    self.starships.append(contentsOf: starships)
                case .failure(let error):
                    print(error) //FIXME: handle error properly
                }
            }
            pageNumber += 1
            
        } while pageNumber < 5 // FIXME: get rid of magic number
        
    }
    
    // MARK: - NavBarItem
    
    func changeNavBarTitle() {
        navigationItem.title = selectedEntity
    }
    
    // MARK: - Table View

    func tableViewDesign() {
        moreInfoTableView.backgroundView = nil
        moreInfoTableView.backgroundColor = UIColor.black
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return moreInfoTableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return currentSelection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Entity(rawValue: selectedEntity!)! {
        case .person:
            return personInfo.count
        case .vehicle:
            return vehicleInfo.count
        case .starship:
            return starshipInfo.count
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "swapiCell", for: indexPath) as! InfoCell
            switch Entity(rawValue: selectedEntity!)! {
            case .person:
                cell.titleLabel.text = Person().description[indexPath.row]
                cell.descriptionLabel.text = personInfo[indexPath.row]
            case .vehicle:
                cell.titleLabel.text = Vehicle().description[indexPath.row]
                cell.descriptionLabel.text = vehicleInfo[indexPath.row]
            case .starship:
                cell.titleLabel.text = Starship().description[indexPath.row]
                cell.descriptionLabel.text = starshipInfo[indexPath.row]
            }
        
        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // MARK: - Picker View
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch Entity(rawValue: selectedEntity!)! {
        case .person:
            return people.count
        case .vehicle:
            return vehicles.count
        case .starship:
            return starships.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch Entity(rawValue: selectedEntity!)! {
        case .person:
            return people[row].name
        case .vehicle:
            return vehicles[row].name
        case .starship:
            return starships[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        swapiClient.fetchVehicles(forPerson: people[row]) { (result) in
//            switch result {
//            case .success(let vehicle):
//                self.people[row].vehicles?.append(vehicle.name)
//            case .failure(let error):
//                print(error) //FIXME: handle error properly
//            }
//        }
        
        switch Entity(rawValue: selectedEntity!)! {
        case .person:
            currentSelection = people[row].name!
            entityName.text = people[row].name!
            personInfo = people[row].summary!
        case .vehicle:
            currentSelection = vehicles[row].name!
            entityName.text = vehicles[row].name!
            vehicleInfo = vehicles[row].summary!
        case .starship:
            currentSelection = starships[row].name!
            entityName.text = starships[row].name!
            starshipInfo = starships[row].summary!
        }
//        personInfo.append((people[row].associatedVehicles as? String)!)
    }
    

}

