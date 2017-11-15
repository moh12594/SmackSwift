//
//  SignUpVC.swift
//  Smack
//
//  Created by Mohamed SADAT on 15/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  @IBAction func closeButtonPressed(_ sender: Any) {
    performSegue(withIdentifier: UNWIND, sender: nil)
    UIApplication.shared.statusBarStyle = .lightContent
  }
  
}
