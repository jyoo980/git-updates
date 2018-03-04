//
//  UserProfileController.swift
//  GitUp
//
//  Created by James Yoo on 2018-03-04.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class UserProfileController: UIViewController {
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    var user : GitHubUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserVisuals()
        userAvatar.layer.cornerRadius = 50
        userAvatar.layer.masksToBounds = true
    }
    
    fileprivate func setUserVisuals() {
        userNameLabel.text = user?.getUserName()
        loadUserAvatar()
    }
    
    fileprivate func loadUserAvatar() {
        let imageUrl = user?.getImageURL()
        Alamofire.request(imageUrl!).responseData{ (response) in
            if response.error == nil {
                print(response.result)
                self.userAvatar.image = UIImage(data: response.data!)
            }
        }
    }
    
}
