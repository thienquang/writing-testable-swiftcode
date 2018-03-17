//
//  SPDLocationSpeedProviderTests.swift
//  SpeedometerTests
//
//  Created by Thien Le quang on 3/17/18.
//  Copyright © 2018 Thien Le quang. All rights reserved.
//

import XCTest
@testable import Speedometer
import CoreLocation

class SPDLocationSpeedProviderTests: XCTestCase {
  var sut: SPDLocationSpeedProvider!
  
  var locationProviderMock: SPDLocationProviderMock!
  var delegateMock: SPDLocationSpeedProviderDelegateMock!
  
  override func setUp() {
    super.setUp()
    
    locationProviderMock = SPDLocationProviderMock()
    delegateMock = SPDLocationSpeedProviderDelegateMock()
    
    sut = SPDDefaultLocationSpeedProvider(locationProvider: locationProviderMock)
    sut.delegate = delegateMock
  }
  
  func test_consumeLocation_speedLessThanZero_provideZeroToDelegate() {
    // Arrange
    let location = createLocation(with: -10)
    // Act
    locationProviderMock.lastConsumer?.consumeLocation(location)
    // Assert
    XCTAssertEqual(0, delegateMock.lastSpeed)
  }
  
  func test_consumeLocation_speedGreaterThanZero_provideSpeedToDelegate() {
    // Arrange
    let location = createLocation(with: 10)
    // Act
    locationProviderMock.lastConsumer?.consumeLocation(location)
    // Assert
    XCTAssertEqual(10, delegateMock.lastSpeed)
  }
  
  func createLocation(with speed: CLLocationSpeed) -> CLLocation {
    let coordinate = CLLocationCoordinate2D()
    
    return CLLocation(coordinate: coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, course: 0, speed: speed, timestamp: Date())
  }
  
}
