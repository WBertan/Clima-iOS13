//
//  WeatherModel.swift
//  Clima
//
//  Created by William Da Silva on 16/02/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...299:
            return "cloud.bolt.rain"
        case 300...399:
            return "cloud.drizzle"
        case 500...599:
            return "cloud.rain"
        case 600...699:
            return "snow"
        case 700...799:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...899:
            return "cloud"
        default:
            return "questionmark.diamond"
        }
    }
    
}
