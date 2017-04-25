//
//  TableCell.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/25/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.white
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        descriptionLabel.textColor = UIColor.white
        
        setupViews()
        
        self.backgroundColor = UIColor.black
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        func setupViews() {
            addSubview(titleLabel)
            addSubview(descriptionLabel)
    
            let views = [
                "title" : titleLabel,
                "description" : descriptionLabel
            ]
    
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[title]-20-[description]-100-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[description]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        }
    
    
    
    
}
