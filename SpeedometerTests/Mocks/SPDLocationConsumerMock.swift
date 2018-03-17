//
//  SPDLocationConsumerMock.swift
//  SpeedometerTests
//
//  Created by Thien Le quang on 3/17/18.
//  Copyright © 2018 Thien Le quang. All rights reserved.
//

import Foundation
@testable import Speedometer

import CoreLocation

class SPDLocationConsumerMock: SPDLocationConsumer {
  var lastLocation: CLLocation?
  
  func consumeLocation(_ location: CLLocation) {
    lastLocation = location
  }
}

