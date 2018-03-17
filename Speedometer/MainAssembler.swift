//
//  MainAssembler.swift
//  Speedometer
//
//  Created by Thien Le quang on 3/16/18.
//  Copyright © 2018 Thien Le quang. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class MainAssembler {
  var resolver: Resolver {
    return assembler.resolver
  }
  private let assembler = Assembler(container: SwinjectStoryboard.defaultContainer)
  
  init() {
    assembler.apply(assembly: SPDLocationManagerAssembly())
    assembler.apply(assembly: SPDLocationAuthorizationAssembly())
    assembler.apply(assembly: SPDLocationProviderAssembly())
    assembler.apply(assembly: SPDDefaultLocationSpeedCheckerAssembly())
    assembler.apply(assembly: SPDLocationSpeedProviderAssembly())
    
    assembler.apply(assembly: ViewControllerAssembly())
  }
}
