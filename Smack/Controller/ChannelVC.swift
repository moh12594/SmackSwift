//
//  ChannelVC.swift
//  Smack
//
//  Created by Mohamed SADAT on 14/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

  // Outlets
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var channelTable: UITableView!
  @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
  
  override func viewDidLoad() {
    super.viewDidLoad()
    channelTable.delegate = self
    channelTable.dataSource = self
    self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    setupUserInfo()
  }
  
  
  @IBAction func addChannelPressed(_ sender: Any) {
    let addChannel = AddChannelVC()
    addChannel.modalPresentationStyle = .custom
    present(addChannel, animated: true, completion: nil)
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
    setupUserInfo()
  }
  
  func setupUserInfo() {
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

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = channelTable.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
      let channel = MessageService.instance.channels[indexPath.row]
      cell.configureCell(channel: channel)
      return cell
    } else {
      return UITableViewCell()
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MessageService.instance.channels.count
  }
}
