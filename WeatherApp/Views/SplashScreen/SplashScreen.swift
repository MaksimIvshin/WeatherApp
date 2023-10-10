//
//  SplashScreen.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 20.09.23.
//

import SwiftUI
// Splash screen.
struct SplashScreen: View {
    // State property to track home screen activity.
    @State var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @ObservedObject private var currentViewModel = CurrentWeatherViewModel()
    @ObservedObject private var sevenDaysViewModel = SevenDaysViewModel()
    var body: some View {
        if isActive {
            ContentView()
                .preferredColorScheme(.light)
        } else {
            ZStack {
                Color.white
                VStack{
                    Image("weatherIcon", bundle: nil)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.1)) {
                        self.size = 1.5
                        self.opacity = 1
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                currentViewModel.requestLocation()
                sevenDaysViewModel.requestLocation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
