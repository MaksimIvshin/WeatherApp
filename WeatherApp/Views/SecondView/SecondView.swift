//
//  SecondView.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 22.08.23.
//

import SwiftUI

struct SecondView: View {
    @StateObject private var searchByCityViewModel = SearchByCityViewModel()

    var body: some View {
        VStack {
            TextField("Введите город", text: $searchByCityViewModel.cityName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Получить погоду") {
                searchByCityViewModel.fetchWeatherData()
            }
            .padding()

            if let weatherData = searchByCityViewModel.weatherData {
                Text("Город: \(weatherData.city.name)")
                Text("Страна: \(weatherData.city.country)")
                Text("Температура днем: \(searchByCityViewModel.tempDay)")
            }
        }
        .padding()
    }
}


struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
