//
//  Angela course projects.swift
//  Clima
//
//  Created by Amr El-Fiqi on 10/04/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    // MARK: - Variables
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=&units=metric"
    
    
    // MARK: - Struct Functions
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        perfrormRequest(urlString: urlString)
    }
    
    func perfrormRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let urlSession = URLSession(configuration: .default)
            
            let task = urlSession.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherStruct.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            print(id)
            let weatherModel = WeatherModel(conditionId: id, cityName: name, temprature: temp)
            return weatherModel
        }
        catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}

