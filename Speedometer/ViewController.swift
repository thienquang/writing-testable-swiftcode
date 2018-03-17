//
//  ViewController.swift
//  Speedometer
//
//  Created by Thien Le quang on 3/14/18.
//  Copyright © 2018 Thien Le quang. All rights reserved.
//

import UIKit
import CoreLocation
import Swinject
import SwinjectStoryboard

private let maxDisplayableSpeed: CLLocationSpeed = 40 // m/s or 144 km/s

class ViewController: UIViewController {
  
  var speedProvider: SPDLocationSpeedProvider! {
    didSet {
      speedProvider.delegate = self
    }
  }
  var speedChecker: SPDLocationSpeedChecker! {
    didSet {
      speedChecker.delegate = self
    }
  }
  
  @IBOutlet var speedLabels: [UILabel]!
  @IBOutlet weak var speedViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet var colorableViews: [UIView]!
  
  
  @IBAction func didTapMaxSpeed(_ sender: Any) {
    let alertControler = UIAlertController(title: "Pick as max Speed", message: "You will be alerted when you exceed this max speed", preferredStyle: .alert)
    
    alertControler.addTextField { [weak self] (textfield) in
      textfield.keyboardType = .numberPad
      if let maxSpeed = self?.speedChecker.maximumSpeed {
        textfield.text = String(format: "%.0f", maxSpeed.asKMH)
      }
    }

    let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] (_) in
      guard let text = alertControler.textFields?.first?.text else { return }
      
      guard let maxSpeed = Double(text) else { return }
      
      self?.speedChecker.maximumSpeed = maxSpeed.asMPS
    }
    
    alertControler.addAction(okAction)
    
    present(alertControler, animated: true, completion: nil)
  }
  
}

extension ViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    for label in speedLabels {
      label.text = "0"
    }
    speedViewHeightConstraint.constant = 0
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }

}

extension ViewController: SPDlocationSpeedProviderDelegate {
  func didUpdate(speed: CLLocationSpeed) {
    for label in speedLabels {
      label.text = String(format: "$.0f", speed.asKMH)
    }
    view.layoutIfNeeded()
    
    let maxHeight = view.bounds.height
    
    speedViewHeightConstraint.constant = maxHeight * CGFloat(speed / maxDisplayableSpeed)
    
    UIView.animate(withDuration: 1.4) { [weak self] in
      self?.view.layoutIfNeeded()
    }
  }
}

extension ViewController: SPDLocationSpeedCheckerDelegate {
  func exceedingMaximumSpeedChanged(for speedCheker: SPDLocationSpeedChecker) {
    let color: UIColor = speedCheker.isExceedingMaximumSpeed ? .speedometerRed : .speedometerBlue
    
    UIView.animate(withDuration: 1) { [weak self] in
      for view in self?.colorableViews ?? [] {
        if let label = view as? UILabel {
          label.textColor = color
        } else if let button = view as? UIButton {
          button.setTitleColor(color, for: .normal)
        } else {
          view.backgroundColor = color
        }
      }
    }
  }
}

extension UIColor {
  static let speedometerRed = UIColor(red: 255/255, green: 82/255, blue: 0/255, alpha: 1)
  static let speedometerBlue = UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1)
}

extension CLLocationSpeed {
  var asKMH: Double {
    return self * 3.6 // 1 m/s = 3.6km/s
  }
}

extension Double {
  var asMPS: CLLocationSpeed {
    return self / 3.6
  }
}

class ViewControllerAssembly: Assembly {
  func assemble(container: Container) {
    container.storyboardInitCompleted(ViewController.self) { (r, c) in
      c.speedProvider = r.resolve(SPDLocationSpeedProvider.self)!
      c.speedChecker = r.resolve(SPDLocationSpeedChecker.self)!
    }
  }
}
