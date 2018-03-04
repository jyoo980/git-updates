//
//  UserTableViewCell.swift
//  GitUp
//
//  Created by James Yoo on 2018-02-28.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userNameText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        userAvatar.layer.cornerRadius = 40
        userAvatar.layer.masksToBounds = true
    }

}
