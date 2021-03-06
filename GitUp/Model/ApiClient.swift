//
//  ApiClient.swift
//  GitUp
//
//  Created by James Yoo on 2018-08-08.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation

class ApiClient {
    
    private let ERROR_CODE = "500"
    
    func searchForUsers(fullName: String, callBack: @escaping (_ result:NSArray) -> ()) {
        getUserSearchData(fullName: fullName) { result -> () in
            callBack(result)
        }
    }
    
    private func getUserSearchData(fullName: String , completionHandler: @escaping (_ result:NSArray) ->()) {
        let session = URLSession.shared
        let requestURL = userSearchURL(fullName: fullName)
        
        let dataTask = session.dataTask(with: requestURL) { (data, _, _) in
            let responseDict = dataToDict(data: data)
            if let userArray = responseDict.value(forKey: "items") {
                completionHandler(userArray as! NSArray)
            }
        }
        dataTask.resume()
    }
    
    private func userSearchURL(fullName: String) -> URL {
        let nameArray = getNameArray(name: fullName)
        let requestURL = parseIntoURL(name: nameArray)
        return URL(string: requestURL)!
    }
    
    private func getNameArray(name: String) -> [String] {
        return name.components(separatedBy: " ")
    }
    
    private func parseIntoURL(name: [String]) -> String {
        var baseUrl = "https://api.github.com/search/users?q={firstName}+{lastName}+in%3Afullname"
        baseUrl = baseUrl.replacingOccurrences(of: "{firstName}", with: name[0])
        baseUrl = baseUrl.replacingOccurrences(of: "{lastName}", with: (name.count != 2) ? "" : name[1])
        return baseUrl
    }
    
}
