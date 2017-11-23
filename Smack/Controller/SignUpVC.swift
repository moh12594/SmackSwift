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
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  // Variables
  var avatarName = "profileDefault"
  var avatarColor = "[0.5, 0.5, 0.5, 1]"
  var bgColor: UIColor?
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }

  override func viewDidAppear(_ animated: Bool) {
    if UserDataService.instance.avatarName != "" {
      profileImage.image = UIImage(named: UserDataService.instance.avatarName)
      avatarName = UserDataService.instance.avatarName
      if avatarName.contains("light") && bgColor == nil {
        profileImage.backgroundColor = UIColor.lightGray
      }
    }
  }
  @IBAction func closeButtonPressed(_ sender: Any) {
    performSegue(withIdentifier: UNWIND, sender: nil)
    UIApplication.shared.statusBarStyle = .lightContent
  }
  
  @IBAction func signUpButtonPressed(_ sender: Any) {
    spinner.isHidden = false
    spinner.startAnimating()
    guard let name = userNameText.text, userNameText.text != "" else {return}
    guard let email = emailText.text, emailText.text != "" else {return}
    guard let password = passwordText.text, passwordText.text != "" else {return}
    AuthService.instance.registerUser(email: email, password: password) { (success) in
      if success {
        AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
          if success {
            AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
              if success {
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                UIApplication.shared.statusBarStyle = .lightContent
                self.performSegue(withIdentifier: UNWIND, sender: nil)
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
              }
            })
          }
        })
      }
    }
    
  }
  
  @IBAction func pickAvatarPressed(_ sender: Any) {
    performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
  }
  
  @IBAction func pickBGColorPressed(_ sender: Any) {
    let red = CGFloat(arc4random_uniform(255)) / 255
    let green = CGFloat(arc4random_uniform(255)) / 255
    let blue = CGFloat(arc4random_uniform(255)) / 255
    bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    avatarColor = "[\(red), \(green), \(blue), 1]"
    UIView.animate(withDuration: 0.3) {
      self.profileImage.backgroundColor = self.bgColor
    }
  }
  
  func setupView() {
    spinner.isHidden = true
    userNameText.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
    emailText.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
    passwordText.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
    let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpVC.handleTap))
    view.addGestureRecognizer(tap)
  }
  
  @objc func handleTap() {
    view.endEditing(true)
  }
  
}
