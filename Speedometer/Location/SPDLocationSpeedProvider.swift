//
//  SPDLocationSpeedProvider.swift
//  Speedometer
//
//  Created by Thien Le quang on 3/15/18.
//  Copyright © 2018 Thien Le quang. All rights reserved.
//

import Foundation
import CoreLocation
import Swinject

protocol SPDlocationSpeedProviderDelegate: class {
  func didUpdate(speed: CLLocationSpeed)
}

protocol SPDLocationSpeedProvider: class {
  var delegate: SPDlocationSpeedProviderDelegate? { get set }
}

class SPDDefaultLocationSpeedProvider {
  
  weak var delegate: SPDlocationSpeedProviderDelegate?
  
  let locationProvider: SPDLocationProvider
  
  init(locationProvider: SPDLocationProvider) {
    self.locationProvider = locationProvider
    
    locationProvider.add(self)
  }
}

extension SPDDefaultLocationSpeedProvider: SPDLocationSpeedProvider {
  
}

extension SPDDefaultLocationSpeedProvider: SPDLocationConsumer {
  func consumeLocation(_ location: CLLocation) {
    let speed = max(location.speed, 0)
    
    delegate?.didUpdate(speed: speed)
  }
}

class SPDLocationSpeedProviderAssembly: Assembly {
  func assemble(container: Container) {
    container.register(SPDLocationSpeedProvider.self, factory: { r in
      let locationProvider = r.resolve(SPDLocationProvider.self)!
      return SPDDefaultLocationSpeedProvider(locationProvider: locationProvider)
    }).inObjectScope(.weak)
  }
}
