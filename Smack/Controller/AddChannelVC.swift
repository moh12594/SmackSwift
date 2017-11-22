//
//  AddChannelVC.swift
//  Smack
//
//  Created by Mohamed SADAT on 21/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

  //Outlets
  @IBOutlet weak var nameText: UITextField!
  @IBOutlet weak var descriptionText: UITextField!
  @IBOutlet weak var bgView: UIView!
  

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }
  
  @IBAction func createChannelPressed(_ sender: Any) {
    guard let channelName = nameText.text, nameText.text != "" else {return}
    guard let channelDescription = descriptionText.text else {return}
    SocketService.instance.AddChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func closeModalPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  func setUpView() {
    let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
    bgView.addGestureRecognizer(closeTouch)
    
    nameText.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
    descriptionText.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
  }
  
  @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
    dismiss(animated: true, completion: nil)
  }
}
