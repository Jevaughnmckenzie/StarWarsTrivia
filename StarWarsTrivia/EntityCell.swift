//
//  EntityCell.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/25/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import UIKit


class EntityCell: UITableViewCell {
    
    let entityImage = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(entityImage)
        addSubview(entityLabel)
        
        let views = [
            "image" : entityImage,
            "text" : entityLabel
        ]
        
        let metrics = [
            "imageWidth" : 125 as AnyObject,
            "imageHeight" : 125 as AnyObject,
            "textLength" : 30 as AnyObject
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[text]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        entityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        entityImage.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[image(imageWidth)]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        entityImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[image(imageHeight)]-8-[text]", options: NSLayoutFormatOptions(), metrics: metrics, views: views))
        
        
        
    }
    
    let entityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.blue
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    
    
}







































