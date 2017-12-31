//
//  CustomMessageCell.swift
//  Flash Chat
//
//  Created by Tevin Mantock on 12/28/2017.
//  Copyright (c) 2017 Tevin Mantock. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {
    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code goes here
    }
}
