//
//  Extension+Date.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 24.08.23.
//

import Foundation

extension Date {
    static func formattedDate(timestamp: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return dateFormatter.string(from: date)
    }
}
