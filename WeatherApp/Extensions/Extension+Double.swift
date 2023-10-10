//
//  Extension+Double.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 22.08.23.
//

import Foundation
// Rounding Double to Int and converting to String.
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}
