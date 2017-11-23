//
//  ChatVC.swift
//  Smack
//
//  Created by Mohamed SADAT on 14/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

  // Outlets
  @IBOutlet weak var menuButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var messageField: UITextField!
  @IBOutlet weak var messagesTable: UITableView!
  @IBOutlet weak var sendButton: UIButton!
  
  // Variables
  var isTyping = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.bindToKeyboard()
    messagesTable.delegate = self
    messagesTable.dataSource = self
    
    messagesTable.estimatedRowHeight = 100
    messagesTable.rowHeight = UITableViewAutomaticDimension
    sendButton.isHidden = true
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
    view.addGestureRecognizer(tap)
    menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
  
    NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNELS_SELECTED, object: nil)
    
    SocketService.instance.getChatMessage { (success) in
      if success {
        self.messagesTable.reloadData()
        if MessageService.instance.messages.count > 0 {
          let lastIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
          self.messagesTable.scrollToRow(at: lastIndex, at: .bottom, animated: false)
        }
      }
    }
    if AuthService.instance.isLoggedIn {
      AuthService.instance.findUserByEmail(completion: { (success) in
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
      })
    }
  }
  
  @objc func userDataDidChange(_ notif: Notification) {
    if AuthService.instance.isLoggedIn {
      onLoginGetMessages()
    } else {
      titleLabel.text = "Please Log In"
      messagesTable.reloadData()
    }
  }
  
  @objc func channelSelected(_ notif: Notification) {
    updateWithChannel()
  }
  
  @objc func handleTap() {
    view.endEditing(true)
  }
  
  @IBAction func messageFieldEditing(_ sender: Any) {
    if messageField.text == "" {
      isTyping = false
      sendButton.isHidden = true
    } else {
      if isTyping == false {
        sendButton.isHidden = false
      }
      isTyping = true
    }
  }
  
  @IBAction func sendMessagePressed(_ sender: Any) {
    if AuthService.instance.isLoggedIn {
      guard let channelId = MessageService.instance.selectedChannel?.id else {return}
      guard let message = messageField.text else {return}
      SocketService.instance.sendMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
        if success {
          self.messageField.text = ""
          self.messageField.resignFirstResponder()
        }
      })
    }
  }
  
  func updateWithChannel() {
    let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
    titleLabel.text = "# \(channelName)"
    getMessages()
  }
  
  func onLoginGetMessages() {
    MessageService.instance.findAllChannels { (success) in
      if success {
        if MessageService.instance.channels.count > 0 {
          MessageService.instance.selectedChannel = MessageService.instance.channels[0]
          self.updateWithChannel()
        } else {
          self.titleLabel.text = "No Channel yet !"
        }
      }
    }
  }
  
  func getMessages() {
    guard let channelId = MessageService.instance.selectedChannel?.id else {return}
    MessageService.instance.findMessagesByChannel(channelId: channelId) { (success) in
      self.messagesTable.reloadData()
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = messagesTable.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
      let message = MessageService.instance.messages[indexPath.row]
      cell.configureCell(message: message)
      return cell
    } else {
      return UITableViewCell()
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MessageService.instance.messages.count
  }
  

}
