//
//  MasterViewController.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import UIKit

class HomeScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    var detailViewController: DetailViewController? = nil
    
    @IBOutlet weak var moreInfoSelector: UIPickerView!
    @IBOutlet weak var moreInfoTableView: UITableView!
    
   
    let swapiClient = SWAPIClient()
    
    var people: [Person] = [] {
        didSet {
            moreInfoSelector.reloadAllComponents()
        }
    }
    
    var personInfo: [String] = [] {
        didSet {
           moreInfoTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableViewDesign()
        moreInfoTableView.register(TableCell.self, forCellReuseIdentifier: "swapiCell")
        
        moreInfoSelector.delegate = self
        moreInfoSelector.dataSource = self
        moreInfoTableView.delegate = self
        moreInfoTableView.dataSource = self
        
        showAllPeople()
    }
    
    override func viewWillLayoutSubviews() {

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Programatic Views
    
    func setUpTableView() {
       
    }
    
    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = moreInfoTableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
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
    
    // MARK: - Table View

    func tableViewDesign() {
        moreInfoTableView.backgroundView = nil
        moreInfoTableView.backgroundColor = UIColor.black
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return personInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "swapiCell", for: indexPath) as! TableCell

        cell.titleLabel.text = Person().description[indexPath.row]
        cell.descriptionLabel.text = personInfo[indexPath.row]
        
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
        personInfo = people[row].summary!
//        personInfo.append((people[row].associatedVehicles as? String)!)
    }
    
    

}

