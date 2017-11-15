//
//  RoundedButton.swift
//  Smack
//
//  Created by Mohamed SADAT on 15/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

  @IBInspectable var cornerRadius:  CGFloat = 3.0 {
    didSet {
      self.layer.cornerRadius = cornerRadius
    }
  }

  override func awakeFromNib() {
     self.setupView()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    self.setupView()
  }
  
  func setupView() {
    self.layer.cornerRadius = cornerRadius
  }
}
