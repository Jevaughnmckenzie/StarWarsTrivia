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
    @IBOutlet weak var smallestEntityLabel: UILabel!
    @IBOutlet weak var largestEntityLabel: UILabel!
    
    let swapiClient = SWAPIClient()
    var selectedEntity: String?
    var entitesAcendingSize = [JSONDecodable]()
   
    // MARK: Pickerwheel Data
    var entities: [SWAPIEntity] = [] {
        didSet {
            moreInfoSelector.reloadAllComponents()
        }
    }
    

    var currentSelection: String = ""
    
    // MARK: - TableView Data
    
    var entityInfo: [String] = [] {
        didSet{
            moreInfoTableView.reloadData()
            compareSizes()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        changeNavBarTitle()
        
        moreInfoTableView.register(TableHeader.self, forHeaderFooterViewReuseIdentifier: "header")
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Updating PickerView lists
    
    func showAllPeople() {
        var pageNumber = 1
        repeat {
            swapiClient.fetchAllPeople(type: .allPeople(page: pageNumber)) { (result) in
                switch result {
                case .success(let people):
                    self.entities.append(contentsOf: people as [SWAPIEntity])
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
                    self.entities.append(contentsOf: vehicle as [SWAPIEntity])
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
                    self.entities.append(contentsOf: starships as [SWAPIEntity])
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
        return entityInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "swapiCell", for: indexPath) as! InfoCell
            switch Entity(rawValue: selectedEntity!)! {
            case .person:
                cell.titleLabel.text = Person().description[indexPath.row]
                cell.descriptionLabel.text = entityInfo[indexPath.row]
            case .vehicle:
                cell.titleLabel.text = Vehicle().description[indexPath.row]
                cell.descriptionLabel.text = entityInfo[indexPath.row]
            case .starship:
                cell.titleLabel.text = Starship().description[indexPath.row]
                cell.descriptionLabel.text = entityInfo[indexPath.row]
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
        return entities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return entities[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelection = entities[row].name!
        entityName.text = entities[row].name!
        entityInfo = entities[row].summary!
//        personInfo.append((people[row].associatedVehicles as? String)!)
    }
    
    // MARK: - Size Comparison functions
    
    func compareSizes() {
        /*
         1)extract name and size information from downloaded json info
         2)itterate over info to sort by size from smallest to largest
         3)assign name of entity corresponding to smallest or largest size to the appropriate UILabel
         */
        
        var size1: Int?
        var size2: Int?
        var names: [SWAPIEntity]?
        
        var intermListOFEntities = [SWAPIEntity]()
        for entity in entities {
            switch Entity(rawValue: selectedEntity!)! {
            case .person:
                if Int((entity as! Person).height!) != nil {
                    intermListOFEntities.append(entity)
                }
                names = intermListOFEntities.sorted(by: { (entity1, entity2) -> Bool in
                    size1 = Int((entity1 as! Person).height!)
                    size2 = Int((entity2 as! Person).height!)
                     return size1! < size2!
                })
            case .vehicle:
                if Int((entity as! Vehicle).length!) != nil {
                    intermListOFEntities.append(entity)
                }
                names = intermListOFEntities.sorted(by: { (entity1, entity2) -> Bool in
                    size1 = Int((entity1 as! Vehicle).length!)
                    size2 = Int((entity2 as! Vehicle).length!)
                    return size1! < size2!
                })
            case .starship:
                if Int((entity as! Starship).length!) != nil {
                    intermListOFEntities.append(entity)
                }
                names = intermListOFEntities.sorted(by: { (entity1, entity2) -> Bool in
                    size1 = Int((entity1 as! Starship).length!)
                    size2 = Int((entity2 as! Starship).length!)
                    return size1! < size2!
                })
            }
        }
        
        smallestEntityLabel.text = names?.first?.name
        largestEntityLabel.text = names?.last?.name
    }
}
































