//
//  Extension+Double.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 22.08.23.
//

import Foundation

extension Double {
    func roundDouble() -> String {
        return String(format: "%.1f", self)
    }
}
