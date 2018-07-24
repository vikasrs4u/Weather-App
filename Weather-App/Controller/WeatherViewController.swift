//
//  WeatherViewController.swift
//  Weather-App
//
//  Created by Vikas R S on 7/15/18.
//  Copyright © 2018 Vikas Radhakrishna Shetty. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SwiftGifOrigin

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {

    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "31e7d3b0d44002435656d630745bf6f8"
    
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var mainScreenBackground: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mainScreenBackground.image = UIImage.gif(name:"londoncity")
        
        temperatureLabel.isHidden = true
        //Set up the location manager here.
        locationManager.delegate = self
        
        // to set the accuracy level
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // to request user for permission after this remember to add the
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()


    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getWeatherData(url:String, parameters:[String:String])
    {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in

            if(response.result.isSuccess)
            {
                print("We are Succcessfully able to call the weather data.")
                let weatherJSON :JSON = JSON(response.result.value!)
                
                self.updateWeatherData(jsonValue: weatherJSON)

             }
            
            if (response.result.isFailure)
            {
                print("Its a failure to call the weather URL \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Error"
            }
        }

    }

    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    
    //Write the updateWeatherData method here:
    
    func updateWeatherData(jsonValue:JSON)
    {
        // below Optional wrapping is required to avoid app crashing incase we get error code from the api call
        
        if let tempValue = jsonValue["main"]["temp"].double
        {
            weatherDataModel.cityName = jsonValue["name"].stringValue
            weatherDataModel.temperatureInCelcius = Int(tempValue - 273.15)
            weatherDataModel.weatherConditionCode = jsonValue["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.weatherConditionCode)
            
            // below method will update all UI labels and image views
            updateUIWithWeatherData()
        }
        else
        {
            cityLabel.text = "Weather Unavailable"
        
        }

    }
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    func updateUIWithWeatherData()
    {
        cityLabel.text = weatherDataModel.cityName
    
        temperatureLabel.text = "\(weatherDataModel.temperatureInCelcius)℃"
        
        temperatureLabel.isHidden = false
        
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
        mainScreenBackground.image = UIImage.gif(name:"londoncity")
    }
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        // locations is an array and we need the last well know location. So in that array we are taking the last value, i.e Last well know location
        let location = locations[locations.count-1]
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        //The radius of uncertainty for the location, measured in meters. If this "horizontalAccuracy" is negative then it means our location data is not proper.
        if (location.horizontalAccuracy > 0)
        {
            locationManager.stopUpdatingLocation()
            
            locationManager.delegate = nil
            print("Latitude value is \(latitude) and the longitude value is \(longitude) ")
            // this is to match sample API call for openweather https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22
            // all 3 lat, lon and appid and required
            let params : [String:String] = ["lat":latitude, "lon":longitude, "appid":APP_ID]
            
            getWeatherData(url:WEATHER_URL , parameters:params)
        }

        
    }
    
    
    
    
    
    //Write the didFailWithError method here:
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error occured while fetching location");
        
        cityLabel.text = "Location Unavailable"
    }
    
    
    
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //The userEnteredNewCity Delegate method here:
    
    func userEnteredNewCity(city: String)
    {
        print(city)
    }
    
    
    //Write the PrepareForSegue Method here
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "changeCityName")
        {
            let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.delegate = self
        }
    }
    
    
    
    
    
}
