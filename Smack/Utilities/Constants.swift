//
//  Constants.swift
//  Smack
//
//  Created by Mohamed SADAT on 14/11/2017.
//  Copyright © 2017 Mohamed SADAT. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// Api URL Constant
let BASE_URL = "https://slackysmack.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_CREATE = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail"
let URL_GET_CHANNELS = "\(BASE_URL)channel"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel"

// Colors
let smackPurplePlaceHolder = #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)

// Notification constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNELS_SELECTED = Notification.Name("channelSelected")

// Segues
let TO_LOGIN = "toLogin"
let TO_SIGNUP = "toSignUp"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// User Defaults
let TOKEN_KEY = "key"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
  "Content-Type": "application/json; charset=utf-8"
]
let BEARER_HEADER = [
  "Authorization": "Bearer \(AuthService.instance.authToken)",
  "Content-Type": "application/json; charset=utf-8"
]
