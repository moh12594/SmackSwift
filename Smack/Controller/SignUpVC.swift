//
//  SignUpVC.swift
//  Smack
//
//  Created by Mohamed SADAT on 15/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

  // Outlets
  @IBOutlet weak var userNameText: UITextField!
  @IBOutlet weak var emailText: UITextField!
  @IBOutlet weak var passwordText: UITextField!
  
  @IBOutlet weak var profileImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }

  @IBAction func closeButtonPressed(_ sender: Any) {
    performSegue(withIdentifier: UNWIND, sender: nil)
    UIApplication.shared.statusBarStyle = .lightContent
  }
  
  @IBAction func signUpButtonPressed(_ sender: Any) {
    guard let email = emailText.text, emailText.text != "" else {return}
    guard let password = passwordText.text, passwordText.text != "" else {return}
    
    AuthService.instance.registerUser(email: email, password: password) { (success) in
      if success {
        print("Registred user !")
      }
    }
    
  }
  
  @IBAction func pickAvatarPressed(_ sender: Any) {
  }
  
  @IBAction func pickBGColorPressed(_ sender: Any) {
  }
  
  
}
