//
//  MainViewController.swift
//  GitUp
//
//  Created by James Yoo on 2018-03-03.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var followedUsersTable: UITableView!
    private var followedUsers : [GitHubUser] = []
    
    override func viewDidLoad() {
        setFollowedUsers()
    }
    
    fileprivate func setFollowedUsers() {
        let userCache = FollowedUserCache.shared.cache
        if !userCache.isEmpty {
            for (_, value) in userCache {
                followedUsers.append(value)
            }
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO
        return UITableViewCell()
    }

}
