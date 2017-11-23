//
//  SocketService.swift
//  Smack
//
//  Created by Mohamed SADAT on 22/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

  static let instance = SocketService()
  
  override init() {
    super.init()
  }
  
  var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
  
  func establishConnection() {
    socket.connect()
  }
  
  func closeConnection() {
    socket.disconnect()
  }
  
  func AddChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
    socket.emit("newChannel", channelName, channelDescription)
    completion(true)
  }
  
  func getChannel(completion: @escaping CompletionHandler) {
    socket.on("channelCreated") { (dataArray, ack) in
      guard let channelName = dataArray[0] as? String else {return}
      guard let channelDescription = dataArray[1] as? String else {return}
      guard let channelId = dataArray[2] as? String else {return}
      
      let newChannel = Channel(channelTitle: channelName, channelDescription: channelDescription, id: channelId)
      MessageService.instance.channels.append(newChannel)
      completion(true)
    }
  }
  
  func sendMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
    let user = UserDataService.instance
    
    socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
    completion(true)
  }
  
  func getChatMessage(completion: @escaping CompletionHandler) {
    socket.on("messageCreated") { (dataArray, ack) in
      guard let messageBody = dataArray[0] as? String else {return}
      guard let channelId = dataArray[2] as? String else {return}
      guard let userName = dataArray[3] as? String else {return}
      guard let userAvatar = dataArray[4] as? String else {return}
      guard let userAvatarColor = dataArray[5] as? String else {return}
      guard let id = dataArray[6] as? String else {return}
      guard let timeStamp = dataArray[7] as? String else {return}
      if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
        let newMessage = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
        MessageService.instance.messages.append(newMessage)
        completion(true)
      } else {
        completion(false)
      }
    }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
