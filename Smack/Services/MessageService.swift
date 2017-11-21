//
//  MessageService.swift
//  Smack
//
//  Created by Mohamed SADAT on 21/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
  
  static let instance = MessageService()
  
  var channels = [Channel]()
  
  func findAllChannels(completion: @escaping CompletionHandler) {
    Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
      
      if response.result.error == nil {
        
        guard let data = response.data else {return}
        if let json = JSON(data: data).array {
          for item in json {
            let name = item["name"].stringValue
            let channelDesription = item["description"].stringValue
            let id = item["_id"].stringValue
            let channel = Channel(channelTitle: name, channelDescription: channelDesription, id: id)
            self.channels.append(channel)
          }
          completion(true)
        }
        
      } else {
        completion(false)
        debugPrint(response.result.error as Any)
      }
      
    }
    
  }
  
}
