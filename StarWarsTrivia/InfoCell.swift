//
//  TableCell.swift
//  StarWarsTrivia
//
//  Created by Jevaughn McKenzie on 4/25/17.
//  Copyright © 2017 Jevaughn McKenzie. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var unitLabel: UILabel?
    var uSDollarButton = UIButton()
    var gCreditsButton = UIButton()
    var metricUnitsButton = UIButton()
    var englishUnitsButton = UIButton()
    var conversionRate: String?
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = UIColor.lightGray
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionLabel.textColor = UIColor.white
        
        setupViews()
        
        self.backgroundColor = UIColor.black
        
        gCreditsButton.tag = 10
        uSDollarButton.tag = 20
        
        
        
        metricUnitsButton.isEnabled = false
        gCreditsButton.isEnabled = false
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)

        addSubview(metricUnitsButton)
        addSubview(englishUnitsButton)
        
        addSubview(uSDollarButton)
        addSubview(gCreditsButton)
        
        
        designButton(metricUnitsButton, withTitle: "Metric")
        designButton(englishUnitsButton, withTitle: "English")
        designButton(uSDollarButton, withTitle: "USD")
        designButton(gCreditsButton, withTitle: "Credits")
        
        var views = [
            "title" : titleLabel,
            "description" : descriptionLabel,
            "english" : englishUnitsButton,
            "usd" : uSDollarButton,
            "galacticCredits" : gCreditsButton,
            "metric" : metricUnitsButton
        ] as [String : Any]

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[title]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-150-[description]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[usd]-[galacticCredits]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[usd]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[galacticCredits]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[english]-[metric]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[english]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[metric]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[title]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[description]-|", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        
        // Adds the units label to length and height cells if applicable
        if (titleLabel.text == "Length") || (titleLabel.text == "Height") {
//            descriptionLabel.text = String(Int(Double(descriptionLabel.text!)! / 100.0))
            unitLabel = UILabel()
            unitLabel?.text = "m"
            addSubview(unitLabel!)
            unitLabel?.translatesAutoresizingMaskIntoConstraints = false
            unitLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            unitLabel?.textColor = UIColor.white
            views["units"] = unitLabel!
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[description]-[units]", options: NSLayoutFormatOptions(), metrics: nil, views: views))
        }
    }
    
//    var metricUnitsButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Metric", for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.setTitleColor(UIColor.lightGray, for: .highlighted)
//        return button
//    }()
    
    func designButton(_ button: UIButton, withTitle title: String) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .disabled)
    }
    
    func convertToEnglishUnits() {
        let toEnglishMultiplier = 3.28
        unitLabel?.text = "ft"
        
        guard let metricUnits = Double(descriptionLabel.text!) else {
            return
        }
        let englishUnits = metricUnits * toEnglishMultiplier
        descriptionLabel.text = String(Int(englishUnits))
        //        descriptionLabel.text! += (unitLabel?.text!)!
        englishUnitsButton.isEnabled = false
        metricUnitsButton.isEnabled = true
    }
    
    func convertToMetricUnits() {
        let toMetricMultiplier = 1/3.28
        unitLabel?.text = "m"
        
        guard let englishUnits = Double(descriptionLabel.text!) else {
            return // FIXME: use proper error handeling
        }
        let metricUnits = englishUnits * toMetricMultiplier
        descriptionLabel.text = String(Int(metricUnits))
        metricUnitsButton.isEnabled = false
        englishUnitsButton.isEnabled = true
    }
    
    
}






































