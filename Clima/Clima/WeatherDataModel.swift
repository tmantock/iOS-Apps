//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Tevin Mantock on 12/26/2017.
//  Copyright (c) 2017 Tevin Mantock. All rights reserved.
//

import UIKit

class WeatherDataModel {

    var location : String?
    var temperature : Int?
    var condition : Int?
    var weatherIconName : String?
    
    init(location : String, temperature : Double, condition : Int) {
        self.location = location
        self.temperature = Int(temperature - 273.15)
        self.condition = condition
    }
    
    func updateWeatherIcon() -> String {
        guard let condition = self.condition else { return "" }

        switch (condition) {
            case 0...300 :
                return "tstorm1"
            case 301...500 :
                return "light_rain"
            case 501...600 :
                return "shower3"
            case 601...700 :
                return "snow4"
            case 701...771 :
                return "fog"
            case 772...799 :
                return "tstorm3"
            case 800 :
                return "sunny"
            case 801...804 :
                return "cloudy2"
            case 900...903, 905...1000  :
                return "tstorm3"
            case 903 :
                return "snow5"
            case 904 :
                return "sunny"
            default :
                return "dunno"
        }
    }
}
