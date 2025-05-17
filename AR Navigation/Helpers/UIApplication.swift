//
//  UIApplication.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 17/05/25.
//

import SwiftUI

extension UIApplication {
  func hideKeyboard() {
    sendAction(
      #selector(UIResponder.resignFirstResponder),
      to: nil,
      from: nil,
      for: nil
    )
  }
}
