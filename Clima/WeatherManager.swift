//
//  WeatherManager.swift
//  Clima
//
//  Created by William Da Silva on 10/02/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    
    func didFailWithError(_ error: Error)
    
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    private let queryParams = [
        "appId": "<insert your key here>",
        "units": "metric"
    ]
    
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    private func buildBaseWeatherURL() -> String {
        return queryParams.reduce(weatherURL) { (acc, queryParam) -> String in
            "\(acc)&\(queryParam.key)=\(queryParam.value)"
        }
    }
    
    func fetchWeather(cityName: String) {
        let urlString = "\(buildBaseWeatherURL())&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(lat: Double, lon: Double) {
        let urlString = "\(buildBaseWeatherURL())&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        if let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: safeUrlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
                if let error = error {
                    self.delegate?.didFailWithError(error)
                    return
                }
                if let data = data, let weatherData = self.parseJson(data) {
                    let weatherModel = self.parse(data: weatherData)
                    self.delegate?.didUpdateWeather(self, weather: weatherModel)
                }
            }
            task.resume()
        }
    }
    
    private func parseJson(_ weatherData: Data) -> WeatherData? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(WeatherData.self, from: weatherData)
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    private func parse(data: WeatherData) -> WeatherModel {
        return WeatherModel(
            conditionId: data.weather[0].id,
            cityName: data.name,
            temperature: data.main.temp
        )
    }
    
}
