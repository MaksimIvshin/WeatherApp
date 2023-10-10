//
//  CityNameWeatherData.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 30.08.23.
//

import Foundation
// Weather data by the city.
struct CityNameWeatherData: Codable {
    let city: City
    let cod: String
    let message: Double
    let cnt: Int
    let list: [List2]
}
struct City: Codable {
    let id: Int
    let name: String
    let country: String
    let population, timezone: Int
}
struct List2: Codable {
    let temp: Temp2
    let weather: [Weather2]
}
struct Temp2: Codable {
    let day, min, max, night: Double
}
struct Weather2: Codable {
    let main, description, icon: String
}
