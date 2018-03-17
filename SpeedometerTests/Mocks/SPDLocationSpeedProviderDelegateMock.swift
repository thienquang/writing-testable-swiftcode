//
//  SPDLocationSpeedProviderDelegateMock.swift
//  SpeedometerTests
//
//  Created by Thien Le quang on 3/17/18.
//  Copyright © 2018 Thien Le quang. All rights reserved.
//

import Foundation
@testable import Speedometer
import CoreLocation

class SPDLocationSpeedProviderDelegateMock: SPDlocationSpeedProviderDelegate {
  var lastSpeed: CLLocationSpeed?
  
  func didUpdate(speed: CLLocationSpeed) {
      lastSpeed = speed
  }
}
