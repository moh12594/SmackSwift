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
  
  @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
      
  }
  
  @IBAction func loginButtonPressed(_ sender: Any) {
    performSegue(withIdentifier: TO_LOGIN, sender: nil)
    
  }
  
  
  

}
