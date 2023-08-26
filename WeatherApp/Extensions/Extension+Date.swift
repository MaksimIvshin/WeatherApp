//
//  Extension+Date.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 24.08.23.
//

import Foundation
//Расширение для даты и преобразовани в строку в формате: дня и месяца.
extension Date {
    static func formattedDate(date: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        return dateFormatter.string(from: date)
    }
}
