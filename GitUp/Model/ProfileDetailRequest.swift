//
//  ProfileDetailRequest.swift
//  GitUp
//
//  Created by James Yoo on 2018-03-04.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation

class ProfileDetailRequest {
    
    private var detailDict = [String:String]()
    
    func getProfileDetails(user: GitHubUser) {
        let requestUrl = user.getPageURL()
        let dataTask = session.dataTask(with: requestUrl) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    let responseDict = dataToDict(data: data)
                    self.parseProfileData(dict: responseDict)
                }
            }
        }
        dataTask.resume()
    }
    
    fileprivate func parseProfileData(dict: NSDictionary) {
        
    }
    
}
