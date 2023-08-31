//
//  FirstView.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 22.08.23.
//

import SwiftUI

struct FirstView: View {
    //Создаем свойства и методы.
    @StateObject private var currentViewModel = CurrentWeatherViewModel()
    @StateObject private var sevenDaysViewModel = SevenDaysViewModel()
    //Используется для отслеживания состояния сцены
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
                Spacer()
            }
            .padding(.top, 200)
            SevenDaysScroll(sevenDaysViewModel: sevenDaysViewModel)
                .padding(.top, 600)
        }
        .ignoresSafeArea()
        .foregroundColor(.white)
        //Действия выполняются при предствалении на экран.
        .onAppear {
            currentViewModel.requestLocation()
            sevenDaysViewModel.requestLocation()
        }
        //Метод используется при изменении состояния сцены.
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
