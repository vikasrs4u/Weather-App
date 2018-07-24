//
//  ChangeCityViewController.swift
//  Weather-App
//
//  Created by Vikas R S on 7/16/18.
//  Copyright © 2018 Vikas Radhakrishna Shetty. All rights reserved.
//

import UIKit
import SwiftGifOrigin

protocol ChangeCityDelegate
{
    func userEnteredNewCity(city:String)
    
}


class ChangeCityViewController: UIViewController
{
    
    @IBOutlet weak var changeCityBackground: UIImageView!
    
    override func viewDidLoad()
    {
        changeCityBackground.image = UIImage.gif(name:"newyork")
    }
    
    //Declare the delegate variable here "?" is given at the end to state if 
    var delegate : ChangeCityDelegate?
    
    // Here "?" is given because cityName may or may not be entered by user
    var cityName:String?
    
    //This is the pre-linked IBOutlets to the text field:
    @IBOutlet weak var changeCityTextField: UITextField!
    
    
    //This is the IBAction that gets called when the user taps on the "Get Weather" button:
    @IBAction func getWeatherPressed(_ sender: AnyObject)
    {
        //City name the user entered in the text field is set
        
        cityName = changeCityTextField.text!
        
        
        //If we have a delegate set, call the method userEnteredANewCityName
        // "?" means optional Chaining, means it checks if delegate is present or not, if present then only will call "userEnteredNewCity" method
        delegate?.userEnteredNewCity(city: cityName!)
        
        
        //dismisses the Change City View Controller to go back to the WeatherViewController
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
    @IBAction func backButtonPressed(_ sender: AnyObject)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}
