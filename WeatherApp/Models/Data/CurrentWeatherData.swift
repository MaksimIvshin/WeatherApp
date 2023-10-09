//
//  CurrentWeatherData.swift.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 18.08.23.
//

import Foundation
// Curerent weather data.
struct CurrentWeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let name: String
    let visibility: Int
}
struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
}
struct Sys: Codable {
    let country: String
}
struct Weather: Codable {
    let description: String
    let main: String
}
struct Wind: Codable {
    let speed: Double
}
