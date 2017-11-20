//
//  ChannelVC.swift
//  Smack
//
//  Created by Mohamed SADAT on 14/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

  // Outlets
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var profileImage: UIImageView!
  @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
  }
  
  @IBAction func loginButtonPressed(_ sender: Any) {
    if AuthService.instance.isLoggedIn {
      let profile = ProfileVC()
      profile.modalPresentationStyle = .custom
      present(profile, animated: true, completion: nil)
      
    } else {
      performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
  }
  
  @objc func userDataDidChange(_ notif: Notification) {
    if AuthService.instance.isLoggedIn {
      loginButton.setTitle(UserDataService.instance.name, for: .normal)
      profileImage.image = UIImage(named: UserDataService.instance.avatarName)
      profileImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
    } else {
      loginButton.setTitle("Login", for: .normal)
      profileImage.image = UIImage(named: "menuProfileIcon")
      profileImage.backgroundColor = UIColor.clear
    }
  }
  

}
