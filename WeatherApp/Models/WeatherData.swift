//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 18.08.23.
//

import Foundation

struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let name: String
    let cod: Int
}

struct Main: Codable {
    let temp: Double
}

struct Sys: Codable {
    let country: String
    let sunrise, sunset: Int
}

struct Weather: Codable {
    let description: String
}

struct Wind: Codable {
    let speed: Double
}
