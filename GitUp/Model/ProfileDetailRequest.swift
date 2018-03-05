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
                    self.parseProfileData(dict: responseDict, user: user)
                }
            }
        }
        dataTask.resume()
    }
    
    fileprivate func parseProfileData(dict: NSDictionary, user: GitHubUser) {
        let realName = dict.value(forKey: "name") as! String
        user.setActualName(name: realName)
    }
    
}
