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

    func getUserSearchData(fullName: String, completionHandler: @escaping (([String:String]) -> ())) {
        let session = URLSession.shared
        let requestURL = getRequestURL(fullName: fullName)
        
        let dataTask = session.dataTask(with: requestURL!) { (data, response, error) in
            
            if let data = data {
                let responseDict = dataToDict(data: data)
                // TODO Parse into User array
            }
            
        }
    }
    
    fileprivate func getRequestURL(fullName: String) -> URL? {
        let firstName = getFirstName(fullName: fullName)
        let lastName = getLastName(fullName: fullName)
        var requestURL = self.request.replacingOccurrences(of: "{firstName}", with: firstName)
        requestURL = requestURL.replacingOccurrences(of: "{lastName}", with: lastName)
        return URL(string: requestURL)
    }
    
    fileprivate func getFirstName(fullName: String) -> String {
        var token = fullName.components(separatedBy: " ")
        return token[0]
    }
    
    fileprivate func getLastName(fullName: String) -> String {
        var token = fullName.components(separatedBy: " ")
        return token[1]
    }
    
    
    
    
}
