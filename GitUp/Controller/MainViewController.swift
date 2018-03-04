//
//  MainViewController.swift
//  GitUp
//
//  Created by James Yoo on 2018-03-03.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var followedUsersTable: UITableView!
    private var followedUsers : [GitHubUser] = []
    
    override func viewDidLoad() {
        setFollowedUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setFollowedUsers()
        super.viewWillAppear(animated)
        followedUsersTable.reloadData()
    }
    
    fileprivate func setFollowedUsers() {
        let userCache = FollowedUserCache.shared.cache
        if !userCache.isEmpty {
            for (_, value) in userCache {
                if (!followedUsers.contains(value)) {
                    followedUsers.append(value)
                }
            }
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = followedUsersTable.dequeueReusableCell(withIdentifier: "cell") as! UserTableViewCell
        
        let user = followedUsers[indexPath.row] as GitHubUser
        setUserNameText(cell, user)
        setUserAvatar(gitHubUser: user, cell: cell)
        return cell
    }
    
    fileprivate func setUserNameText(_ cell: UserTableViewCell, _ user: GitHubUser) {
        cell.userNameText.text = user.getUserName()
    }
    
    fileprivate func setUserAvatar(gitHubUser: GitHubUser, cell: UserTableViewCell) {
        let imageUrl = gitHubUser.getImageURL()
        Alamofire.request(imageUrl).responseData{ (response) in
            if response.error == nil {
                print(response.result)
                cell.userAvatar.image = UIImage(data: response.data!)
            }
        }
    }

}
