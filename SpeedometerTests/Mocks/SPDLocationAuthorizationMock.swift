//
//  SPDLocationAuthorizationMock.swift
//  SpeedometerTests
//
//  Created by Thien Le quang on 3/17/18.
//  Copyright © 2018 Thien Le quang. All rights reserved.
//

import Foundation
@testable import Speedometer

class SPDLocationAuthorizationMock: SPDLocationAuthorization {
  weak var delegate: SPDLocationAuthorizationDelegate?
  
  var didCheckedAuthorization = false
  
  func checkAuthorization() {
    didCheckedAuthorization = true
  }
}
