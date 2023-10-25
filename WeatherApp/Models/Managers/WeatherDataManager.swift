//
//  WeatheManager.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 24.08.23.
//

import Foundation
import CoreLocation

final class WeatherDataManager: ObservableObject {
    // API keys.
    private let apiKey = "b5a50c398a579b44871a884663a2845a"
    private let apiKeyAnother = "ed60fcfbd110ee65c7150605ea8aceea"
    // Receiving current weather by location.
    func fetchCurrentWeather(forLocation location: CLLocation, compltion: @escaping (CurrentWeatherData?)->Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            compltion (nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            let weather = try? JSONDecoder().decode(CurrentWeatherData.self, from: data)
            if let weather = weather {
                compltion(weather)
            } else {
                compltion(nil)
            }
        }.resume()
    }
    // Receiving weather data for 7 days by location.
    func fetchSevenDaysWeather(forLocation location: CLLocation, compltion: @escaping (SevenDaysWeatherData?)->Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&cnt=8&appid=\(apiKeyAnother)&units=metric"
        guard let url = URL(string: urlString) else {
            compltion (nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            let weather = try? JSONDecoder().decode(SevenDaysWeatherData.self, from: data)
            if let weather = weather {
                compltion(weather)
            } else {
                compltion(nil)
            }
        }.resume()
    }
    // Receive weather data for the city.
    func cityNameDaysWeather(forCity city: String, compltion: @escaping (CityNameWeatherData?)->Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast/daily?q=\(city)&cnt=1&appid=\(apiKeyAnother)&units=metric"
        guard let url = URL(string: urlString) else {
            compltion (nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            let weather = try? JSONDecoder().decode(CityNameWeatherData.self, from: data)
            if let weather = weather {
                compltion(weather)
            } else {
                compltion(nil)
            }
        }.resume()
    }
}
