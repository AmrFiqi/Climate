//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//
import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    
    // MARK: - Struct Objects
    
    var weatherManager = WeatherManager()
    
    // MARK: - IBActions
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchOrGoPressed()
    }
    
    // MARK: - Class Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    
    func searchOrGoPressed() {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
}

    // MARK: - UI Text Field Delegate & Extension

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchOrGoPressed()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            textField.placeholder = "Search"
            return true
        }
        else {
            textField.placeholder = "Type Something!"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Get the text field and search the city
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
}

    // MARK: - Weather Manager Delegate & Extension

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempratureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(String(describing: error))
    }
}


