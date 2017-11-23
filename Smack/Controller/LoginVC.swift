//
//  LoginVC.swift
//  Smack
//
//  Created by Mohamed SADAT on 15/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

  //Outlets
  @IBOutlet weak var userNameText: UITextField!
  @IBOutlet weak var passwordText: UITextField!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
  }
  
  
  @IBAction func closeButtonPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    UIApplication.shared.statusBarStyle = .lightContent
  }
  
  @IBAction func signUpButtonPressed(_ sender: Any) {
    performSegue(withIdentifier: TO_SIGNUP, sender: nil)
  }
  
  @IBAction func loginButtonPressed(_ sender: Any) {
    spinner.isHidden = false
    spinner.startAnimating()
    guard let userName = userNameText.text , userNameText.text != "" else {return}
    guard let password = passwordText.text , passwordText.text != "" else {return}
    AuthService.instance.loginUser(email: userName, password: password) { (success) in
      if success {
        AuthService.instance.findUserByEmail(completion: { (success) in
          if success {
            NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
            UIApplication.shared.statusBarStyle = .lightContent
            self.dismiss(animated: true, completion: nil)
          }
        })
      }
    }
  }
  
  func setUpView() {
    UIApplication.shared.statusBarStyle = .default
    spinner.isHidden = true
    userNameText.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
    passwordText.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
  }
}
