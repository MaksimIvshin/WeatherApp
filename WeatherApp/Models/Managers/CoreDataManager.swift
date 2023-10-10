//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Maks Ivshin on 21.09.23.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    // Create the database property CoreData.
    let persistentContainer: NSPersistentContainer
    // Initialize CoreDataManager and load database storage.
    init() {
        persistentContainer = NSPersistentContainer(name: "CityWeatherDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }
    // Getting all cities.
    func getAllCity() -> [CityWeather] {
        let fetchRequest: NSFetchRequest<CityWeather> = CityWeather.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    // Save data about the city's weather.
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
    // Save changes in the CoreData context, if the are.
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
    // Deleting a city weather.
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
