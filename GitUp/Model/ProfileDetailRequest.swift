//
//  ProfileDetailRequest.swift
//  GitUp
//
//  Created by James Yoo on 2018-03-04.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation

class ProfileDetailRequest {
    
    func updateProfileDetails(user: GitHubUser) {
        let requestUrl = user.getPageURL()
        let session = URLSession.shared
        let dataTask = session.dataTask(with: requestUrl) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    let responseDict = dataToDict(data: data)
                    self.parsePersonals(dict: responseDict, user: user)
                }
            }
        }
        dataTask.resume()
    }
    
    fileprivate func setUserBio(_ dict: NSDictionary, _ user: GitHubUser) {
        if let bio = dict.value(forKey: "bio") as? String {
            user.setBio(bio: bio)
        } else {
            user.setBio(bio: "No bio")
        }
    }
    
    fileprivate func parsePersonals(dict: NSDictionary, user: GitHubUser) {
        let realName = dict.value(forKey: "name") as! String
        setUserBio(dict, user)
        user.setActualName(name: realName)
        
    }
    
}
