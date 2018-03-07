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

class UserProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBioText: UITextView!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var userRepoTable: UITableView!

    var user : GitHubUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUserInfoCard()
        userRepoTable.reloadData()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func fillUserInfoCard() {
        userAvatar.image = user?.getAvatar()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let numCells = user?.getRepositories().count {
            return numCells
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repositories = user?.getRepositories()
        let cell = userRepoTable.dequeueReusableCell(withIdentifier: "cell") as! UserRepositoryCell
        
        let repo = repositories![indexPath.row] as! Repository
        return cell
    }
    
}
