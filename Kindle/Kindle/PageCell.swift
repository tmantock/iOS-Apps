//
//  PageCell.swift
//  Kindle
//
//  Created by Tevin Mantock on 11/5/17.
//  Copyright © 2017 Tevin Mantock. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Some Text here"

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLabel)
        
        textLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
