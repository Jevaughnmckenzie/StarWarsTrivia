//
//  TableHeader.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/25/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import UIKit


class TableHeader: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[name]", options: NSLayoutFormatOptions(), metrics: nil, views: ["name" : nameLabel]))
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[name]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["name" : nameLabel]))
    }
}































