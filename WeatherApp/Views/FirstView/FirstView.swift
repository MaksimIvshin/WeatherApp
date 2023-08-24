//
//  FirstView.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 22.08.23.
//

import SwiftUI

struct FirstView: View {

    @ObservedObject private var currentViewModel = CurrentWeatherViewModel()
    @ObservedObject private var sevenDaysViewModel = SevenDaysViewModel()

    @Environment(\.scenePhase) private var scenePhase

    var body: some View {

        ZStack {
            Color.backgroundColorFirstView
            VStack {
                Text("\(currentViewModel.city)")
                    .font(.largeTitle)

                Text("\(currentViewModel.temperature)")
                    .font(.system(size: 100))

                Text("\(sevenDaysViewModel.date)")
                    .font(.system(size: 20))

                Text("\(currentViewModel.description)")
                Text("\(currentViewModel.weatherIcon)")
                    .font(.title)

                Spacer()
                SevenDaysScroll()
                Spacer()
            }

            .padding(.top, 200)
            .foregroundColor(.white)



        }
        .ignoresSafeArea()

        .onChange(of: scenePhase) { newScenePhase in
            if newScenePhase == .active {
                currentViewModel.requestLocation()
                if let location = currentViewModel.locationManager.location{
                    sevenDaysViewModel.sevenDaysFetchWeather(forLocation: location)
                }
                if let location = currentViewModel.locationManager.location {
                    currentViewModel.currentFetchWeather(forLocation: location)
                }
            }
        }
        .onAppear{
            currentViewModel.requestLocation()
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
