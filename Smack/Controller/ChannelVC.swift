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
    NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
    SocketService.instance.getChannel { (success) in
      if success {
        self.channelTable.reloadData()
      }
    }
    
    SocketService.instance.getChatMessage { (newMessage) in
      if newMessage.channelId != MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
        MessageService.instance.unreadChannels.append(newMessage.channelId)
        self.channelTable.reloadData()
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    setupUserInfo()
  }
  
  
  @IBAction func addChannelPressed(_ sender: Any) {
    if AuthService.instance.isLoggedIn {
      let addChannel = AddChannelVC()
      addChannel.modalPresentationStyle = .custom
      present(addChannel, animated: true, completion: nil)
    } else {
      performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
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
  
  @objc func channelsLoaded(_ notif: Notification) {
    channelTable.reloadData()
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
      channelTable.reloadData()
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let channel = MessageService.instance.channels[indexPath.row]
    MessageService.instance.selectedChannel = channel
    
    if MessageService.instance.unreadChannels.count > 0 {
      MessageService.instance.unreadChannels = MessageService.instance.unreadChannels.filter{$0 != channel.id}
    }
    let index = IndexPath(row: indexPath.row, section: 0)
    channelTable.reloadRows(at: [index], with: .none)
    channelTable.selectRow(at: index, animated: false, scrollPosition: .none)
    
    NotificationCenter.default.post(name: NOTIF_CHANNELS_SELECTED, object: nil)
    self.revealViewController().revealToggle(animated: true)
  }
}
