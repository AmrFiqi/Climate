//
//  WeatherStruct.swift
//  Clima
//
//  Created by Amr El-Fiqi on 11/04/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherStruct: Decodable{
    let name: String
    let weather: [Weather]
    let main: Main
    
    
    struct Weather: Decodable {
        var id: Int
        var description: String
    }
    
    struct Main: Decodable{
        var temp: Double
        var feelsLike: Double
        var minTemp: Double
        var maxTemp: Double
        var pressure: Double
        var humidity: Double
        
        enum CodingKeys: String, CodingKey {
            case feelsLike = "feels_like"
            case minTemp = "temp_min"
            case maxTemp = "temp_max"
            case temp, pressure, humidity
        }
    }
}
