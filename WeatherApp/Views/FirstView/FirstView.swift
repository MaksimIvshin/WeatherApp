//
//  FirstView.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 22.08.23.
//

import SwiftUI

struct FirstView: View {
    //Создаем свойства и методы.
    @ObservedObject private var currentViewModel = CurrentWeatherViewModel()
    @ObservedObject private var sevenDaysViewModel = SevenDaysViewModel()
    //Используется для отслеживания состояния сцены
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        ZStack {
            Color.backgroundColorFirstView
            VStack {
                Text("\(currentViewModel.city)")
                    .font(.largeTitle)
                Text("\(currentViewModel.temperature)")
                    .font(.system(size: 100))
                Text("\(currentViewModel.description)")
                Text("\(currentViewModel.weatherIcon)")
                    .font(.title)
                Spacer()
            }
            .padding(.top, 200)
            .foregroundColor(.white)
            VStack {
                Text("Weather forecat for 7 days")
                ScrollView(.horizontal, showsIndicators: false) {
                    //Ленивый стек для меньшей загрузки памяти. Вычисления - по мере отображения на экране.
                    LazyHStack(spacing: 20) {
                        ForEach(sevenDaysViewModel.weatherData, id: \.dt) { weather in
                            VStack {
                                Text("\(Date.formattedDate(date: weather.dt))")
                                Text("\(weather.temp.day.roundDouble())°")
                                Text("\(Icons.icons[weather.weather.first?.main ?? ""] ?? "" )")
                            }
                            .padding(10)
                            .frame(width: 100, height: 100)
                            .background(Color.blue.opacity(0.5))
                            .cornerRadius(10)
                        }
                    }
                }
                .frame(maxHeight: 120)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                Spacer()
            }
            .padding(.top, 600)
            .foregroundColor(.white)
        }
        .ignoresSafeArea()
        //Метод используется при изменении состояния сцены.
        .onChange(of: scenePhase) { newScenePhase in
            if newScenePhase == .active {
                currentViewModel.requestLocation()
                sevenDaysViewModel.requestLocation()
                //                if let location = currentViewModel.locationManager.location{
                //                    sevenDaysViewModel.sevenDaysFetchWeather(forLocation: location)
                //                }
                //                if let location = currentViewModel.locationManager.location {
                //                    currentViewModel.currentFetchWeather(forLocation: location)
                //                }
            }
        }
        //Действия выполняются при предствалении на экран.
        .onAppear{
            currentViewModel.requestLocation()
            sevenDaysViewModel.requestLocation()
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
