//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Tevin Mantock on 12/26/2017.
//  Copyright (c) 2017 Tevin Mantock. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    func userEnteredNewCityName(city: String)
}

class ChangeCityViewController: UIViewController {
    
    var delegate : ChangeCityDelegate?

    @IBOutlet weak var changeCityTextField: UITextField!

    //This is the IBAction that gets called when the user taps on the "Get Weather" button:
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        guard let city = changeCityTextField.text else { return }
        delegate?.userEnteredNewCityName(city: city)
        self.dismiss(animated: true, completion: nil)
    }
    
    //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
