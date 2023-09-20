//
//  CityNameWeatherData.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 30.08.23.
//

import Foundation

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
//    let coord: Coord
    let country: String
    let population, timezone: Int
}

//struct Coord: Codable {
//    let lon, lat: Double
//}

struct List2: Codable {
//    let dt, sunrise, sunset: Int
    let temp: Temp2
//    let feelsLike: FeelsLike
//    let humidity: Int
////    let weather: [Weather2]
//    let speed: Double
//    let deg: Int
//    let gust: Double
//    let clouds, pop: Int
//    let rain: Double
}

//struct FeelsLike: Codable {
//    let day, night, eve, morn: Double
//}

struct Temp2: Codable {
    let day, min, max, night: Double
//    let eve: Int
//    let morn: Double
}
//
//struct Weather2: Codable {
//    let id: Int
//    let main, description, icon: String
//}
