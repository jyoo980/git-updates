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
                    self.makeRepoInfoRequest(dict: responseDict, user: user)
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
    
    fileprivate func makeRepoInfoRequest(dict: NSDictionary, user: GitHubUser) {
        let url = dict.value(forKey: "repos_url") as! String
        let request = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request!) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    let repoArray = dataToArray(data: data)
                    self.parseRepositories(repositories: repoArray!!, user: user)
                }
            }
        }
        dataTask.resume()
    }
    
    fileprivate func parseRepositories(repositories: NSArray, user: GitHubUser) {
        for repo in repositories {
            let repoDictionary = repo as! NSDictionary
            extractRepoData(repo: repoDictionary, user: user)
        }
    }
    
    fileprivate func extractRepoData(repo: NSDictionary, user: GitHubUser) {
        let name = repo.value(forKey: "full_name") as! String
        var repo = Repository(owner: user.getUserName(), name: name)
        user.addRepository(repo: repo)
    }
}
    

