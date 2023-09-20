//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 15.09.23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "cloud.sun.rain.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.blue)

            Text("Welcome!")
                .font(.title)
                .fontWeight(.bold)
                .padding()

        }
        .padding()
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

