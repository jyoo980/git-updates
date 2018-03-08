//
//  UserRepositoryCell.swift
//  GitUp
//
//  Created by James Yoo on 2018-03-06.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation
import UIKit

class UserRepositoryCell: UITableViewCell {
    
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        repoImage.layer.cornerRadius = 15
        repoImage.clipsToBounds = true

    }
    
    func setRepositoryName(name: String) {
        repoNameLabel.text = name
    }
    
}
