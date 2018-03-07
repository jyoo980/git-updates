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
    private var bio: String?
    private var pageURL : String
    private var imageURL : String
    private var repositories: [Repository]
    
    init(name: String, page: String, image: String) {
        userName = name
        pageURL = page
        imageURL = image
        repositories = []
    }
    
    func getUserName() -> String {
        return userName
    }
    
    func getActualName() -> String  {
        return actualName!
    }
    
    func getBio() -> String? {
        return bio
    }
    
    func getPageURL() -> URL {
        return URL(string: pageURL)!
    }
    
    func getImageURL() -> URL {
        return URL(string: imageURL)!
    }

    func getRepositories() -> [Repository] {
        return repositories
    }
    
    func setActualName(name: String) {
        actualName = name
    }
    
    func setBio(bio: String) {
        self.bio = bio
    }
    
}

extension GitHubUser: Equatable {
    
    static func ==(lhs: GitHubUser, rhs: GitHubUser) -> Bool {
        return lhs.getPageURL() == rhs.getPageURL()
    }
    
}
