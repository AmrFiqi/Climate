//
//  Angela course projects.swift
//  Clima
//
//  Created by Amr El-Fiqi on 10/04/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        perfrormRequest(urlString: urlString)
    }
    
    func perfrormRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let urlSession = URLSession(configuration: .default)
            
            let task = urlSession.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(String(describing: error))
                }
                
                if let safeData = data {
                        parseJSON(weatherData: safeData)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherStruct.self, from: weatherData)
            print(decodedData.main.temp)
        }
        catch {
            print(String(describing: error))
        }
    }
}
