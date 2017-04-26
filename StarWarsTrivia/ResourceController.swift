//
//  MasterViewController.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import UIKit

class ResourceController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    
    
    @IBOutlet weak var moreInfoSelector: UIPickerView!
    @IBOutlet weak var moreInfoTableView: UITableView!
    
    let swapiClient = SWAPIClient()
    var selectedEntity: String?
   
    
    var people: [Person] = [] {
        didSet {
            moreInfoSelector.reloadAllComponents()
        }
    }
    
    var currentSelection: String = ""
    var personInfo: [String] = [] {
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
        default:
            return
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
    
    
    // MARK: - Segues

    
    
    // MARK: Updating People list
    
    func showAllPeople() {
        var peopleResults: String = ""
        var pageNumber = 1
        repeat {
            swapiClient.fetchAllPeople(type: .allPeople(page: pageNumber)) { (result) in
                switch result {
                case .success(let people):
//                    peopleResults = ""
                    peopleResults = "\(people)"
                    self.people.append(contentsOf: people)
                case .failure(let error):
                    print(error) //FIXME: handle error properly
                }
            }
             pageNumber += 1
            
        } while pageNumber < 10 // FIXME: get rid of magic number
        
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
        default:
            return 0
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "swapiCell", for: indexPath) as! InfoCell
            switch Entity(rawValue: selectedEntity!)! {
            case .person:
                cell.titleLabel.text = Person().description[indexPath.row]
                cell.descriptionLabel.text = personInfo[indexPath.row]
            default:
                return UITableViewCell()
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
        return people.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return people[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        swapiClient.fetchVehicles(forPerson: people[row]) { (result) in
            switch result {
            case .success(let vehicle):
                self.people[row].vehicles?.append(vehicle.name)
            case .failure(let error):
                print(error) //FIXME: handle error properly
            }
        }
        currentSelection = people[row].name!
        personInfo = people[row].summary!
//        personInfo.append((people[row].associatedVehicles as? String)!)
    }
    
    

}

