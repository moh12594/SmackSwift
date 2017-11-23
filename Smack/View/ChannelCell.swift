//
//  ChannelCell.swift
//  Smack
//
//  Created by Mohamed SADAT on 21/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

  // Outlets
  @IBOutlet weak var channelName: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    if selected {
      self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
    } else {
      self.layer.backgroundColor = UIColor.clear.cgColor
    }
  }
  
  func configureCell(channel: Channel) {
    let title = channel.channelTitle ?? ""
    channelName.text = "# \(title)"
    
    channelName.font = UIFont(name: "Avenir-Medium", size: 17)
    channelName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7500550176)
    for id in MessageService.instance.unreadChannels {
      if id == channel.id {
        channelName.font = UIFont(name: "Avenir-Black", size: 19)
        channelName.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
      }
    }
  }
}
