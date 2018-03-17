//
//  SPDLocationAuthorizationDelegateMock.swift
//  SpeedometerTests
//
//  Created by Thien Le quang on 3/17/18.
//  Copyright © 2018 Thien Le quang. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationAuthorizationDelegateMock: SPDLocationAuthorizationDelegate {
  
  var authorizationWasDenied = false
  
  func authorizationDenied(for locationAuthorization: SPDLocationAuthorization) {
    authorizationWasDenied = true
  }
}

