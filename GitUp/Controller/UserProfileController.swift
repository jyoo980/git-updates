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
    @IBOutlet weak var userBioText: UITextView!
    @IBOutlet weak var realNameLabel: UILabel!
    var user : GitHubUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserVisuals()
        userAvatar.layer.cornerRadius = 50
        userAvatar.layer.masksToBounds = true
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setUserVisuals() {
        loadUserAvatar()
        userNameLabel.text = user?.getUserName()
        realNameLabel.text = user?.getActualName()
        if user?.getBio() != nil {
            userBioText.text = user?.getBio()
        }
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
