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
    @State private var isShowAlert = false

    var body: some View {
        ZStack {
            Color.backgroundColorSecondView
            VStack {
                Spacer().frame(height: 100)
                TextField("Enter your city", text: $searchByCityViewModel.cityName)
                    .foregroundColor(Color.black)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("Get weather") {
                    if searchByCityViewModel.cityName.isEmpty {
                        isShowAlert = true
                        self.endEditing()
                    } else {
                        searchByCityViewModel.fetchWeatherData()
                        isShowingWeatherSheet = true
                        isShowAlert = false
                        self.endEditing()
                    }
                }
                .padding()
                .background(Color.blue)
                .frame(height: 40)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1))
                .alert(isPresented: $isShowAlert) {
                    Alert(title: Text("Sorry!"), message: Text("Please enter the city"), dismissButton: .default(Text("OK")))}
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(searchByCityViewModel.getAllCityData(), id: \.self) { cityWeather in
                            VStack {
                                HStack {
                                    VStack {
                                        Text(cityWeather.cityName ?? "")
                                            .font(.system(size: 40))
                                    }
                                    Spacer()
                                    VStack {
                                        Text(cityWeather.weatherIcon ?? "")
                                            .font(.system(size: 30))
                                        HStack{
                                            Text("Max: \(cityWeather.tempMax ?? "")")
                                                .font(.system(size: 15))
                                            Text("Min: \(cityWeather.tempMin ?? "")")
                                                .font(.system(size: 15))
                                        }
                                    }
                                    .padding(.trailing, 10)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color.blue.opacity(0.5))
                            .cornerRadius(10)
                            .contextMenu {
                                Button(action: {
                                    searchByCityViewModel.deleteCity(city: cityWeather)
                                    searchByCityViewModel.fetchWeatherData()
                                }) {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .padding()
                }
                .padding(.bottom, 80)
                Spacer()
            }
        }
        .foregroundColor(.white)
        .ignoresSafeArea(.all)
        .sheet(isPresented: $isShowingWeatherSheet) {
            WeatherSheetView(searchByCityViewModel: searchByCityViewModel)
        }
        .onAppear {
            // При каждом появлении SecondView обновляем данные
            searchByCityViewModel.objectWillChange.send()
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
