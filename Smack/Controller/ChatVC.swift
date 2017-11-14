//
//  ChatVC.swift
//  Smack
//
//  Created by Mohamed SADAT on 14/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

  // Outlets
  @IBOutlet weak var menuButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
  
  }
  

}
