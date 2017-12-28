//
//  ViewController.swift
//  WeatherApp
//
//  Created by Tevin Mantock on 12/26/2017.
//  Copyright (c) 2017 Tevin Mantock. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {

    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "3ada3a03e32b69ed8439a913afab37e2"
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    //MARK: - Networking
    func getWeatherData(url : String, params : [String : String]) {
        Alamofire.request(url, method: .get, parameters: params).responseJSON { response in
            if response.result.isFailure {
                self.cityLabel.text = "Unable to retreive data"
                print("Failed to make request to Weather API: \(response.result.error.debugDescription)")

                return
            }
            
            guard let value = response.result.value else { return }
            self.updateWeatherData(json: JSON(value))
        }
    }
    
    //MARK: - JSON Parsing
    func updateWeatherData(json : JSON) {
        guard let location = json["name"].string else { return }
        guard let temperature = json["main"]["temp"].double else { return }
        guard let condition = json["weather"][0]["id"].int else { return }
        
        updateUIWithWeatherData(model: WeatherDataModel(location: location, temperature: temperature, condition: condition))
    }

    //MARK: - UI Updates
    func updateUIWithWeatherData(model : WeatherDataModel) {
        let icon = model.updateWeatherIcon()
        
        cityLabel.text = model.location
        temperatureLabel.text = "\(model.temperature ?? 0)°"
        weatherIcon.image = UIImage(named: icon)
    }

    //MARK: - Location Manager Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            let coords : [String : String] = [
                "lat"   : String(location.coordinate.latitude),
                "lon"  : String(location.coordinate.longitude),
                "appid" : APP_ID,
            ]
            
            getWeatherData(url: WEATHER_URL, params: coords)
        }
    }
 
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        cityLabel.text = "Location Unavailable"
        print(error)
    }

    //MARK: - Change City Delegate methods
    func userEnteredNewCityName(city: String) {
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, params: params)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destination = segue.destination as! ChangeCityViewController
            destination.delegate = self
        }
    }
    
}


