//
//  Extension+Int.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 15.09.23.
//

import Foundation
// Rounding meters to kilometers.
extension Int {
    func metersToKilometrs() -> Int {
        return Int(self) / 1000
    }
}
