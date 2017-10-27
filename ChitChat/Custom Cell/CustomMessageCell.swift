//
//  CustomMessageCell.swift
//  ChitChat
//
//  Created by Renan Avrahami on 10/25/17.
//  Copyright © 2017 Renan Avrahami. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {
    
    
    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    
}
