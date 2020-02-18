//
//  WeatherData.swift
//  Clima
//
//  Created by William Da Silva on 16/02/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
}
