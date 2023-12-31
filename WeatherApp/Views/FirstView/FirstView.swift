//
//  FirstView.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 22.08.23.
//

import SwiftUI
// Main view of the app.
struct FirstView: View {
    @ObservedObject private var currentViewModel = CurrentWeatherViewModel()
    @ObservedObject private var sevenDaysViewModel = SevenDaysViewModel()
    // Track the state of the scene.
    @Environment(\.scenePhase) private var scenePhase
    var body: some View {
        ZStack {
            Color.backgroundColorFirstView
            VStack {
                Text("\(currentViewModel.city)")
                    .font(.largeTitle)
                HStack {
                    Text("\(currentViewModel.temperature)")
                        .font(.system(size: 100))
                    Text("\(currentViewModel.weatherIcon)")
                        .font(.system(size: 130))
                }
                Text("\(currentViewModel.description)")
                    .font(.title)
                    .padding(.bottom, 20)
                VStack{
                    HStack(spacing: 50) {
                        Image(systemName: "thermometer")
                        Image(systemName: "wind")
                        Image(systemName: "drop")
                        Image(systemName: "eye")
                    }
                    .font(.system(size: 40))
                    .padding(10)
                    HStack(spacing: 50) {
                        Text("\(currentViewModel.feelsLike)")
                        Text("\(currentViewModel.windSpeed)")
                        Text("\(currentViewModel.humidity)")
                        Text("\(currentViewModel.visibility)")
                    }
                }
                .frame(width: 380, height: 150)
                .background(Color.blue.opacity(0.5))
                .cornerRadius(10)
                Spacer()
            }
            .padding(.top, 100)
            // View for displaying weather for 7 days.
            SevenDaysScroll(sevenDaysViewModel: sevenDaysViewModel)
                .padding(.top, 600)
        }
        .ignoresSafeArea()
        .foregroundColor(.white)
        // Every time SecondView appears, update the data.
        .onAppear {
            currentViewModel.requestLocation()
            sevenDaysViewModel.requestLocation()
        }
        // The method is used when the scene state changes.
        .onChange(of: scenePhase) { newScenePhase in
            if newScenePhase == .active {
                currentViewModel.requestLocation()
                sevenDaysViewModel.requestLocation()
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
