//
//  WeatherSheet.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 21.09.23.
//

import SwiftUI
// Additional information sheet.
struct WeatherSheetView: View {
    @ObservedObject var searchByCityViewModel: SearchByCityViewModel
    @EnvironmentObject var coreDataManager: CoreDataManager
    // Property for closing sheet.
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundColorSecondView
                VStack {
                    Text("\(searchByCityViewModel.cityName) \(searchByCityViewModel.weatherIcon)")
                        .font(.system(size: 50))
                    Text("max: \(searchByCityViewModel.tempMax), min: \(searchByCityViewModel.tempMin)")
                        .font(.system(size: 30))
                }
                .padding(.bottom, 20)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Weather Details")
                    }
                }
                .navigationBarItems(
                    leading: Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        searchByCityViewModel.resetCityName()
                    }) {
                        Image(systemName: "chevron.left")
                    },
                    trailing: Button(action: {
                        searchByCityViewModel.saveData()
                        presentationMode.wrappedValue.dismiss()
                        searchByCityViewModel.resetCityName()
                    }) {
                        Text("Add")
                    }
                    // Disable the button if data has already been added.
                        .disabled(searchByCityViewModel.isDataAlreadyAdded)
                        .opacity(searchByCityViewModel.isDataAlreadyAdded ? 0 : 1)
                )
            }    .ignoresSafeArea(.all)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    WeatherSheetView(searchByCityViewModel: SearchByCityViewModel())
}
