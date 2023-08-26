//
//  Icons.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 22.08.23.
//

import Foundation
//import SwiftUI
//Структура иконок. Стандартная иконка при ошибке данных и словарь [String:String] для отображения полученных данных с сайта в виде иконки.
struct Icons {
    static let defaultIcon: String = "❓"
    static let icons = [
      "Drizzle" : "🌧",
      "Thunderstorm" : "🌩️",
      "Rain": "🌧",
      "Snow": "❄️",
      "Clear": "☀️",
      "Clouds" : "☁️",
    ]
//     Можно сделать фон?
//    static let icons2 = [
//      "Drizzle" : Image("One")
//    ] as [String : Any]
}

