//
//  SPDLocationSpeedChecker.swift
//  Speedometer
//
//  Created by Thien Le quang on 3/15/18.
//  Copyright © 2018 Thien Le quang. All rights reserved.
//

import Foundation
import CoreLocation
import Swinject

protocol SPDLocationSpeedCheckerDelegate: class {
  func exceedingMaximumSpeedChanged(for speedCheker: SPDLocationSpeedChecker)
}

protocol SPDLocationSpeedChecker: class {
  var delegate: SPDLocationSpeedCheckerDelegate? {get set}
  var maximumSpeed: CLLocationSpeed? { get set }
  var isExceedingMaximumSpeed: Bool { get }
}

class SPDDefaultLocationSpeedChecker {
  weak var delegate: SPDLocationSpeedCheckerDelegate?
  var maximumSpeed: CLLocationSpeed? {
    didSet {
      checkIfSpeedExceeded()
    }
  }
  
  var isExceedingMaximumSpeed: Bool = false {
    didSet {
      delegate?.exceedingMaximumSpeedChanged(for: self)
    }
  }
  
  var lastLocation: CLLocation?
  
  let locationProvider: SPDLocationProvider
  
  init(locationProvider: SPDLocationProvider) {
    self.locationProvider = locationProvider
    
    locationProvider.add(self)
  }
}

private extension SPDDefaultLocationSpeedChecker {
  
  func checkIfSpeedExceeded() {
    if let maximumSpeed = maximumSpeed, let lastLocation = lastLocation {
      isExceedingMaximumSpeed = lastLocation.speed > maximumSpeed
    } else {
      isExceedingMaximumSpeed = false
    }
  }
}

extension SPDDefaultLocationSpeedChecker: SPDLocationSpeedChecker {
  
}

extension SPDDefaultLocationSpeedChecker: SPDLocationConsumer {
  func consumeLocation(_ location: CLLocation) {
    lastLocation = location
  }
}

class SPDDefaultLocationSpeedCheckerAssembly: Assembly {
  func assemble(container: Container) {
    container.register(SPDLocationSpeedChecker.self, factory: { r in
      let locationProvider = r.resolve(SPDLocationProvider.self)!
      return SPDDefaultLocationSpeedChecker(locationProvider: locationProvider)
    }).inObjectScope(.weak)
  }
}
