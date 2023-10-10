//
//  WeatherDataManagerTests.swift
//  WeatherAppTests
//
//  Created by Maks Ivshin on 9.10.23.
//

import XCTest
import CoreLocation
@testable import WeatherApp
// Test for fetch current weather.
class WeatherDataManagerTests: XCTestCase {
    var weatherDataManager: WeatherDataManager!
    // Initialization.
    override func setUp() {
        super.setUp()
        weatherDataManager = WeatherDataManager()
    }
    // Clean up resources after finishing the test.
    override func tearDown() {
        weatherDataManager = nil
        super.tearDown()
    }
    func testFetchCurrentWeather() {
        // Arrange. Create a wait for an asynchronous request
        let expectation = XCTestExpectation(description: "Fetch current weather")
        // CLLocation mock data.
        let location = CLLocation(latitude: 53.92492660398267, longitude: 27.508751796504185)
        // Act.
        weatherDataManager.fetchCurrentWeather(forLocation: location) { currentWeatherData in
            // Assert. Check that we received data.
            XCTAssertNotNil(currentWeatherData)
            // Wait is complete.
            expectation.fulfill()
        }
        // Wait for 5 seconds to complete the wait.
        wait(for: [expectation], timeout: 5.0)
    }
}
