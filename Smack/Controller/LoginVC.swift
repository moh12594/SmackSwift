//
//  LoginVC.swift
//  Smack
//
//  Created by Mohamed SADAT on 15/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    UIApplication.shared.statusBarStyle = .default
  }
  
  
  @IBAction func closeButtonPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    UIApplication.shared.statusBarStyle = .lightContent
  }
  
}
