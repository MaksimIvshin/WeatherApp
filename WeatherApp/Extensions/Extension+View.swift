//
//  Extension+View.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 8.09.23.
//

import SwiftUI
// Hide the keyboard when the user clicks on this element.
extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
