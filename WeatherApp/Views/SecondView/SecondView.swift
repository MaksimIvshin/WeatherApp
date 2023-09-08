//
//  SecondView.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 22.08.23.
//

import SwiftUI

struct SecondView: View {
    @StateObject private var searchByCityViewModel = SearchByCityViewModel()
    @State private var isShowingWeatherSheet = false

    var body: some View {
        ZStack {
            Color.backgroundColorSecondView
            VStack {
                Spacer().frame(height: 100)
                TextField("Enter your city", text: $searchByCityViewModel.cityName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Get weather") {
                    searchByCityViewModel.fetchWeatherData()
                    self.endEditing()
                    isShowingWeatherSheet = true
                }
                .foregroundColor(.white)
                Spacer()
            }
//            VStack {
//                if let weatherData = searchByCityViewModel.weatherData {
//                    Text("City: \(weatherData.city.name)")
//                    Text("Country: \(weatherData.city.country)")
//                    Text("Temperature: \(searchByCityViewModel.tempDay)")
//                }
       //     }
        }
        .ignoresSafeArea(.all)
        .sheet(isPresented: $isShowingWeatherSheet) {
                    // Содержимое для отображения в Sheet
                    WeatherSheetView(viewModel: searchByCityViewModel)
                }

    }
}

struct WeatherSheetView: View {
    @ObservedObject var viewModel: SearchByCityViewModel

    var body: some View {
        ZStack{
            Color.backgroundColorThirdView
            VStack {

                Text("City: \(viewModel.cityName)")
                Text("Temperature: \(viewModel.tempDay)")

                }
        }
        .ignoresSafeArea(.all)

        }

}




struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
