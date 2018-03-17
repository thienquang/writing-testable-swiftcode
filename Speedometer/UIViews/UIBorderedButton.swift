//
//  UIBorderedButton.swift
//  Speedometer
//
//  Created by Thien Le quang on 3/16/18.
//  Copyright © 2018 Thien Le quang. All rights reserved.
//

import UIKit

@IBDesignable
class UIBorderedButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    commonInit()
  }

  func commonInit() {
    layer.cornerRadius = 5
    layer.masksToBounds = true
    layer.borderWidth = 1
    layer.borderColor = titleLabel?.textColor.cgColor
  }
  
  override func prepareForInterfaceBuilder() {
    commonInit()
  }

}
