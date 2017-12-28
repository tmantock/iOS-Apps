//
//  HomeDataSourceController.swift
//  Twitter
//
//  Created by Tevin Mantock on 11/8/17.
//  Copyright © 2017 Tevin Mantock. All rights reserved.
//

import LBTAComponents

class UserCell: DatasourceCell {
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()

    override func setupViews() {
        super.setupViews()
        backgroundColor = .yellow
    }
}

class HomeDatasource: Datasource {
    let words = ["user1", "user2", "user3"]
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return words[indexPath.item]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return words.count
    }
}

class HomeDataSourceController: DatasourceController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeDatasource = HomeDatasource()
        self.datasource = homeDatasource
    }
}
