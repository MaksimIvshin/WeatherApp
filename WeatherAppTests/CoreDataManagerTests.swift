//
//  CoreDataManagerTests.swift
//  WeatherAppTests
//
//  Created by Maks Ivshin on 9.10.23.
//

import XCTest
import CoreData
@testable import WeatherApp
// Test for Core Data Manager.
class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManager!
    // Initialization.
    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager()
    }
    // Clean up resources after finishing the test.
    override func tearDown() {
        coreDataManager = nil
        super.tearDown()
    }
    func testSaveAndDeleteCity() {
        // Arrange - data should be provided to the test
        let cityName = "City"
        let tempMax = "25°C"
        let tempMin = "15°C"
        let weatherIcon = "sunny"
        // Act - Invoke the actual method under test. Save the city weather data.
        coreDataManager.saveCityWeather(cityName: cityName, tempMax: tempMax, tempMin: tempMin, weatherIcon: weatherIcon)
        // Get all cities from Core Data.
        let cities = coreDataManager.getAllCity()
        // Assert. Verify that the saved city exists in the list
        XCTAssertTrue(cities.contains { $0.cityName == cityName })
        // Delete the city from Core Data
        if let city = cities.first(where: { $0.cityName == cityName }) {
            coreDataManager.deleteCity(city: city)
        }
        // Get all cities after deletion
        let updatedCities = coreDataManager.getAllCity()
        // Verify that the deleted city is no longer in the list
        XCTAssertFalse(updatedCities.contains { $0.cityName == cityName })
    }
}
