//
//  DetailViewController.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/19/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import UIKit

class ResourceSelectionController: UITableViewController {

    let entities = ["Characters", "Vehicles", "Starships"]
    


    func configureView() {
        // Update the user interface for the detail item.
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(EntityCell.self, forCellReuseIdentifier: "entityCell")
        tableViewDesign()
    }

    
    // MARK: TableView
    
    func tableViewDesign() {
        
        let screenSize = UIScreen.main.bounds
        
        tableView.rowHeight = screenSize.height / CGFloat(entities.count) - 10
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entityCell", for: indexPath) as! EntityCell
        
        cell.entityImage.image = #imageLiteral(resourceName: "icon-characters.png")
        cell.entityLabel.text = entities[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

