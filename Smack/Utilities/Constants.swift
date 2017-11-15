//
//  Constants.swift
//  Smack
//
//  Created by Mohamed SADAT on 14/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// Api URL Constant
let BASE_URL = "https://slackysmack.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"


// Segues
let TO_LOGIN = "toLogin"
let TO_SIGNUP = "toSignUp"
let UNWIND = "unwindToChannel"

// User Defaults
let TOKEN_KEY = "key"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
