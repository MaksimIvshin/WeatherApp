//
//  WeatherData2.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 24.08.23.
//

import Foundation

struct SevenDaysWeatherData: Codable {
    let list: [List]
}
struct List: Codable {
    let dt: Int
    let temp: Temp
    let weather: [WeatherSeven]
}
struct Temp: Codable {
    let day: Double
}
struct WeatherSeven: Codable {
    let id: Int
    let main: String
}
