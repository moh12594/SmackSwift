//
//  ChannelVC.swift
//  Smack
//
//  Created by Mohamed SADAT on 14/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
      
  }


}
