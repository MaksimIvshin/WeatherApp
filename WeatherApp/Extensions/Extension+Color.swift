//
//  Extension+Color.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 22.08.23.
//

import SwiftUI
//Раширение градиентный цвет для главного экрана
extension Color {
    static let backgroundColorFirstView = LinearGradient( colors: [.blue, Color("lightBlue")], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let backgroundColorSecondView = LinearGradient(colors: [.blue,.blue, Color("lightBlue"),  .white], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let backgroundColorThirdView = LinearGradient(colors: [.black,Color("lightBlue"), Color("lightBlue"),  .white], startPoint: .topLeading, endPoint: .bottomTrailing)
}
