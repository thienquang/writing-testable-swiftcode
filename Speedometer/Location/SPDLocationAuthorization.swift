//
//  SPDLocationAuthorization.swift
//  Speedometer
//
//  Created by Thien Le quang on 3/15/18.
//  Copyright © 2018 Thien Le quang. All rights reserved.
//

import Foundation
import CoreLocation
import Swinject

extension NSNotification.Name {
  static let SPDLocationAuthorized = NSNotification.Name(rawValue: "NSNotification.Name.SPDlocationAuthorized")
}

protocol SPDLocationAuthorizationDelegate: class {
  func authorizationDenied(for locationAuthorization: SPDLocationAuthorization)
}

protocol SPDLocationAuthorization: class {
  var delegate: SPDLocationAuthorizationDelegate? { get set }
  func checkAuthorization()
}

class SPDDefaultLocationAuthorization {
  weak var delegate: SPDLocationAuthorizationDelegate?
  let locationManager: SPDLocationManager
  
  
  init(locationManager: SPDLocationManager) {
    self.locationManager = locationManager
    
    locationManager.authorizationDelegate = self
  }
}



extension SPDDefaultLocationAuthorization: SPDLocationAuthorization {
  func checkAuthorization() {
    switch locationManager.authorizationStatus {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    default:
      break
    }
  }
}

extension SPDDefaultLocationAuthorization: SPDLocationManagerAuthorizationDelegate {
  func locationManager(_ manager: SPDLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedWhenInUse, .authorizedAlways:
      NotificationCenter.default.post(name: NSNotification.Name.SPDLocationAuthorized, object: self)
    case .denied, .restricted:
      delegate?.authorizationDenied(for: self)
    default:
      break
    }
  }
}

class SPDLocationAuthorizationAssembly: Assembly {
  func assemble(container: Container) {
    container.register(SPDLocationAuthorization.self, factory: { r in
      let locationManager = r.resolve(SPDLocationManager.self)!
      return SPDDefaultLocationAuthorization(locationManager: locationManager)
    }).inObjectScope(.weak)
  }
}
