//
//  WeatherDataModel.swift
//  Weather-App
//
//  Created by Vikas R S on 7/16/18.
//  Copyright © 2018 Vikas Radhakrishna Shetty. All rights reserved.
//

import UIKit

class WeatherDataModel {
    
    //Declare your model variables here
    
    var temperatureInCelcius:Int
    var cityName:String
    var weatherConditionCode :Int
    var weatherIconName:String
    
    
    // intialzer to give intial values to data models.
    init()
    {
        temperatureInCelcius = 0
        cityName = ""
        weatherConditionCode = 0
        weatherIconName = ""
    }
    
    
    
    
    //Method used to convert the weather code to weather icon name, code is as per https://openweathermap.org/weather-conditions
    
        func updateWeatherIcon(condition: Int) -> String {
    
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

