//
//  Extension+View.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 8.09.23.
//

import SwiftUI

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
