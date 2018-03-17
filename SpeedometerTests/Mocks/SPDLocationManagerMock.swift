//
//  SPDLocationManagerMock.swift
//  SpeedometerTests
//
//  Created by Thien Le quang on 3/17/18.
//  Copyright © 2018 Thien Le quang. All rights reserved.
//

import Foundation
@testable import Speedometer
import CoreLocation

class SPDLocationManagerMock: SPDLocationManager {
  weak var delegate: SPDLocationManagerDelegate?
  
  weak var authorizationDelegate: SPDLocationManagerAuthorizationDelegate?
  
  var authorizationStatus: CLAuthorizationStatus = .notDetermined
  
  
  var requestedWhenInUseAuthoriztion = false
  var didStartUpdatingLocation = false
  var didStopUpdatingLocation = false
  
  func requestWhenInUseAuthorization() {
    requestedWhenInUseAuthoriztion = true
  }
  
  func startUpdatingLocation() {
    didStartUpdatingLocation = true
  }
  
  func stopUpdatingLocation() {
    didStopUpdatingLocation = true
  }
}
