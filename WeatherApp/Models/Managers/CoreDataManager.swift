//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 21.09.23.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {

    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "CityWeatherDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }

    func getAllCity() -> [CityWeather] {
        let fetchRequest: NSFetchRequest<CityWeather> = CityWeather.fetchRequest()
        do {
          return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }

    func saveCityWeather(cityName: String, tempMax: String, tempMin: String, weatherIcon: String) {
        let context = persistentContainer.viewContext
        let cityWeather = CityWeather(context: context)
        cityWeather.cityName = cityName
        cityWeather.tempMax = tempMax
        cityWeather.tempMin = tempMin
        cityWeather.weatherIcon = weatherIcon
        do {
            try context.save()
        } catch {
            print("Failed to save city weather data: \(error)")
        }
    }

    func saveContextIfChange() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func deleteCity(city: CityWeather) {
        persistentContainer.viewContext.delete(city)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print(error)
        }
    }
}
