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
  
  // Variables
  var avatarName = "profileDefault"
  var avatarColor = "[0.5, 0.5, 0.5, 1]"
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func viewDidAppear(_ animated: Bool) {
    if UserDataService.instance.avatarName != "" {
      profileImage.image = UIImage(named: UserDataService.instance.avatarName)
      avatarName = UserDataService.instance.avatarName
    }
  }
  @IBAction func closeButtonPressed(_ sender: Any) {
    performSegue(withIdentifier: UNWIND, sender: nil)
    UIApplication.shared.statusBarStyle = .lightContent
  }
  
  @IBAction func signUpButtonPressed(_ sender: Any) {
    guard let name = userNameText.text, userNameText.text != "" else {return}
    guard let email = emailText.text, emailText.text != "" else {return}
    guard let password = passwordText.text, passwordText.text != "" else {return}
    
    AuthService.instance.registerUser(email: email, password: password) { (success) in
      if success {
        AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
          if success {
            AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
              if success {
                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                self.performSegue(withIdentifier: UNWIND, sender: nil)
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
  }
  
  
}
