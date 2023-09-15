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
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Get weather") {
                    searchByCityViewModel.fetchWeatherData()
                    self.endEditing()
                    isShowingWeatherSheet = true
                }
                .foregroundColor(.white)
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(searchByCityViewModel.dataArray.sorted(), id: \.self) { data in
                            VStack {
                                Text(data)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(Color.blue.opacity(0.5))
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                }
                Spacer()
            }
        }
        .ignoresSafeArea(.all)
        .sheet(isPresented: $isShowingWeatherSheet) {
            WeatherSheetView(searchByCityViewModel: searchByCityViewModel)
        }
        .onAppear {
            // При каждом появлении SecondView обновляем данные
            searchByCityViewModel.objectWillChange.send()
            if !searchByCityViewModel.dataArray.isEmpty {
                searchByCityViewModel.fetchWeatherDataForCities()
            }
        }
    }
}

struct WeatherSheetView: View {
    @ObservedObject var searchByCityViewModel: SearchByCityViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColorSecondView
                VStack {
                    Text("City: \(searchByCityViewModel.cityName)")
                    Text("Temp max: \(searchByCityViewModel.tempMax)")
                    Text("Temp min: \(searchByCityViewModel.tempMin)")
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle(Text("Weather Details"))
                .navigationBarItems(
                    leading: Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    },
                    trailing: Button(action: {
                        searchByCityViewModel.addDataToSet()
                        presentationMode.wrappedValue.dismiss()
                        searchByCityViewModel.resetCityName()
                    }) {
                        Text("Add")
                            .foregroundColor(.white)
                    }
                        .opacity(searchByCityViewModel.isDataAlreadyAdded ? 0 : 1)
                )
            }    .ignoresSafeArea(.all)
        }
    }
}


struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
