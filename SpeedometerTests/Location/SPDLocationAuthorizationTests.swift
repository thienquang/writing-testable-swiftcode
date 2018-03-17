//
//  SPDLocationAuthorizationTests.swift
//  SpeedometerTests
//
//  Created by Thien Le quang on 3/17/18.
//  Copyright © 2018 Thien Le quang. All rights reserved.
//

import XCTest
@testable import Speedometer

class SPDLocationAuthorizationTests: XCTestCase {
  
  var sut: SPDLocationAuthorization!
  
  var locationManagerMock: SPDLocationManagerMock!
  var delegateMock: SPDLocationAuthorizationDelegateMock!
  
  override func setUp() {
    super.setUp()
    
    locationManagerMock = SPDLocationManagerMock()
    delegateMock = SPDLocationAuthorizationDelegateMock()
    
    sut = SPDDefaultLocationAuthorization(locationManager: locationManagerMock)
    sut.delegate = delegateMock
    
  }
  
  
  func test_checkAuthorization_notDetermined_requestsAuthorization() {
    // Arrange
    locationManagerMock.authorizationStatus = .notDetermined
    
    // Act
    sut.checkAuthorization()
    
    // Assert
    XCTAssertTrue(locationManagerMock.requestedWhenInUseAuthoriztion)
  }
  
  func test_checkAuthorization_Determined_doesNotRequestsAuthorization() {
    // Arrange
    locationManagerMock.authorizationStatus = .denied
    
    // Act
    sut.checkAuthorization()
    //  Assert
    XCTAssertFalse(locationManagerMock.requestedWhenInUseAuthoriztion)
  }
  
  func test_didChangeAuthorization_authorizedWhenInUse_notificationIsPosted() {
    // Arange
    let notificationName = NSNotification.Name.SPDLocationAuthorized
    let _ = expectation(forNotification: notificationName, object: sut, handler: nil)
    
    // Act
    locationManagerMock.authorizationDelegate?.locationManager(locationManagerMock, didChangeAuthorization: .authorizedWhenInUse)
    
    // Assert
    waitForExpectations(timeout: 0, handler: nil)
  }
  
  func test_didChangeAuthorization_authorizedAlways_notificationIsPosted() {
    // Arange
    let notificationName = NSNotification.Name.SPDLocationAuthorized
    let _ = expectation(forNotification: notificationName, object: sut, handler: nil)
    
    // Act
    locationManagerMock.authorizationDelegate?.locationManager(locationManagerMock, didChangeAuthorization: .authorizedAlways)
    
    // Assert
    waitForExpectations(timeout: 0, handler: nil)
  }
  
  func test_didChangeAuthorization_authorizedDenied_notificationInformed() {
    // Arrange
    // Act
    locationManagerMock.authorizationDelegate?.locationManager(locationManagerMock, didChangeAuthorization: .denied)
    // Assert
    XCTAssertTrue(delegateMock.authorizationWasDenied)
  }
  
  func test_didChangeAuthorization_authorizedRestricted_notificationInformed() {
    // Arrange
    // Act
    locationManagerMock.authorizationDelegate?.locationManager(locationManagerMock, didChangeAuthorization: .restricted)
    // Assert
    XCTAssertTrue(delegateMock.authorizationWasDenied)
  }
  
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
}
