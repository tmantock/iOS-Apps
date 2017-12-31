//
//  WelcomeViewController.swift
//  Flash Chat
//
//  This is the welcome view controller - the first thign the user sees
//
//  Created by Tevin Mantock on 12/28/2017.
//  Copyright (c) 2017 Tevin Mantock. All rights reserved.
//

import UIKit
import ChameleonFramework

class WelcomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.flatBlack()
        navigationController?.navigationBar.barTintColor = UIColor.flatRed()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
