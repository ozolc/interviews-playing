//
//  MainViewCell.swift
//  binet-task
//
//  Created by Maksim Nosov on 24/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class MainViewCell: UITableViewCell {
    
    var entry: EntryResponseData! {
        didSet {
            daTextLabel.text = entry.da
            
            if entry.da != entry.dm {
                dmTextLabel.text = entry.dm
            }
            
            let text = entry.body
            if text.utf16.count >= 200 {
                let resultPrefix = String(text.prefix(201))
                bodyLabel.text = resultPrefix
            } else {
                bodyLabel.text = text
            }
            
            
        }
    }
    
    let daLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.gray
        label.constrainWidth(constant: 35)
        label.text = "DA:"
        return label
    }()
    
    let daTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor.black
        return label
    }()
    
    let dmLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.gray
        label.constrainWidth(constant: 35)
        label.text = "DM:"
        return label
    }()
    
    let dmTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor.black
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.black
        label.sizeToFit()
        label.numberOfLines = 0
        label.text = "bodyText"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        let backgroundView = UIView()
        
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor.black.cgColor
        backgroundView.layer.cornerRadius = 15
        
//        backgroundView.isUserInteractionEnabled = false
        
        let daStackView = UIStackView(arrangedSubviews: [daLabel, daTextLabel])
        daStackView.distribution = .fill
        daStackView.spacing = 2
        
        let dmStackView = UIStackView(arrangedSubviews: [dmLabel, dmTextLabel])
        daStackView.distribution = .fill
        daStackView.spacing = 2
        
        let overallStackView = VerticalStackView(arrangedSubviews: [daStackView, dmStackView, bodyLabel], spacing: 2)
        overallStackView.distribution = .fill
        backgroundView.addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 5, left: 10, bottom: 5, right: 10))
        
        addSubview(backgroundView)
        backgroundView.fillSuperview(padding: .init(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
