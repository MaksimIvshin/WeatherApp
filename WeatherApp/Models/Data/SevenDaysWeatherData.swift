//
//  WeatherData2.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 24.08.23.
//

import Foundation
// Weather data for 7 days.
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
    let main: String
}
