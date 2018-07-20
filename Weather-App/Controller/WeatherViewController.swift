//
//  WeatherViewController.swift
//  Weather-App
//
//  Created by Vikas R S on 7/15/18.
//  Copyright © 2018 Vikas Radhakrishna Shetty. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "31e7d3b0d44002435656d630745bf6f8"
    
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    
    
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
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
    
    //Write the getWeatherData method here:
    
    
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    
    //Write the updateWeatherData method here:
    
    
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
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
            print("Latitude value is \(latitude) and the longitude value is \(longitude) ")
            // this is to match sample API call for openweather https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22
            // all 3 lat, lon and appid and required
            let params : [String:String] = ["lat":latitude, "lon":longitude, "appid":APP_ID]
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
    
    
    //Write the userEnteredANewCityName Delegate method here:
    
    
    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}
