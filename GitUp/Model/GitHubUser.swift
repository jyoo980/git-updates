//
//  GitHubUser.swift
//  GitUp
//
//  Created by James Yoo on 2018-02-26.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation

class GitHubUser {
    
    private var userName: String
    private var actualName: String?
    private var pageURL : String
    private var imageURL : String
    
    init(name: String, page: String, image: String) {
        userName = name
        pageURL = page
        imageURL = image
    }
    
    func getUserName() -> String {
        return userName
    }
    
    func getActualName() -> String  {
        return actualName
    }
    
    func getPageURL() -> URL {
        return URL(string: pageURL)!
    }
    
    func getImageURL() -> URL {
        return URL(string: imageURL)!
    }
    
    func setActualName(name: String) {
        actualName = name
    }
    
}

extension GitHubUser: Equatable {
    
    static func ==(lhs: GitHubUser, rhs: GitHubUser) -> Bool {
        return lhs.getPageURL() == rhs.getPageURL()
    }
    
}
