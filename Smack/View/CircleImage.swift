//
//  CircleImage.swift
//  Smack
//
//  Created by Mohamed SADAT on 20/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  func setupView() {
    self.layer.cornerRadius = self.frame.width / 2
    self.clipsToBounds = true
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setupView()
  }
}
