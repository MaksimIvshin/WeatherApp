//
//  ContentView.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 18.08.23.
//

import SwiftUI

struct ContentView: View {



    var body: some View {
        TabView{
            FirstView()
                .tabItem {
                    Image(systemName: "cloud.sun.fill")
                    Text("Weather now")
                }
            SecondView()
                .tabItem {
                    Image(systemName: "star.square")
                    Text("Favorite city")
                }
//            Settings()
//                .tabItem {
//                    Image(systemName: "gear")
//                    Text("Settings")
//                }
        }.accentColor(Color.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
