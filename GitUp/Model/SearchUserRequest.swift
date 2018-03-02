//
//  SearchUserRequest.swift
//  GitUp
//
//  Created by James Yoo on 2018-02-26.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation

class SearchUserRequest {
    
    let request = "https://api.github.com/search/users?q={firstName}+{lastName}+in%3Afullname"
    let LOGIN_KEY = "login"
    let URL_KEY = "url"
    let AVATAR_KEY = "avatar_url"

    func getUserSearchData(fullName: String, completionHandler: @escaping (_ result:[GitHubUser]) ->()) {
        let session = URLSession.shared
        let requestURL = getRequestURL(fullName: fullName)
        
        let dataTask = session.dataTask(with: requestURL!) { (data, response, error) in
            
            if let data = data {
                let responseDict = dataToDict(data: data) 
                if let userArray = responseDict.value(forKey: "items") {
                    completionHandler(self.parseGitHubUsers(userArray: userArray as! NSArray))
                }
            }
        }
        dataTask.resume()
    }
    
    fileprivate func getRequestURL(fullName: String) -> URL? {
        let nameAsArray = getNameArray(name: fullName)
        let requestURL = parseIntoURL(name: nameAsArray)
        return URL(string: requestURL)
    }
    
    fileprivate func getNameArray(name: String) -> [String] {
        return name.components(separatedBy: " ")
    }
    
    fileprivate func parseIntoURL(name: [String]) -> String {
        var requestURL = self.request
        if name.count == 2 {
            requestURL = requestURL.replacingOccurrences(of: "{firstName}", with: name[0])
            requestURL = requestURL.replacingOccurrences(of: "{lastName}", with: name[1])
            return requestURL
        } else {
            requestURL = requestURL.replacingOccurrences(of: "{firstName}", with: name[0])
            requestURL = requestURL.replacingOccurrences(of: "{lastName}", with: "")
            return requestURL
        }
    }
    
    fileprivate func parseGitHubUsers(userArray: NSArray) -> [GitHubUser] {
        var userSearchResults = [GitHubUser]()
        for user in userArray {
            addUserToDict(user, &userSearchResults)
        }
        return userSearchResults
    }
    
    fileprivate func addUserToDict(_ user: Any, _ userSearchResults: inout [GitHubUser]) {
        let userDict = user as! NSDictionary
        let userName = userDict.value(forKey: LOGIN_KEY) as! String
        let userURL = userDict.value(forKey: URL_KEY) as! String
        let userImageURL = userDict.value(forKey: AVATAR_KEY) as! String
        userSearchResults.append(GitHubUser(name: userName, page: userURL, image: userImageURL))
    }
    
}
