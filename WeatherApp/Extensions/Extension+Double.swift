//
//  Extension+Double.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 22.08.23.
//

import Foundation
//Расширение для округления чисел Double до 1 знака после точки и конвертации в String.
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}
