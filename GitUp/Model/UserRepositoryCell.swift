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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }
    
    func setRepositoryName(name: String) {
        repoNameLabel.text = name
    }
    
}
