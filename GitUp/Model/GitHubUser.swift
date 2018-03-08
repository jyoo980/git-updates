//
//  GitHubUser.swift
//  GitUp
//
//  Created by James Yoo on 2018-02-26.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class GitHubUser {
    
    private var userName: String
    private var actualName: String?
    private var bio: String?
    private var pageURL : String
    private var imageURL : String
    private var avatar: UIImage?
    private var repositories: [Repository]
    
    init(name: String, page: String, imageURL: String) {
        userName = name
        pageURL = page
        self.imageURL = imageURL
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
    
    func addRepository(repo: Repository) {
        repositories.append(repo)
    }
    
    func getAvatar() -> UIImage {
        return avatar!
    }
    
    func setActualName(name: String) {
        actualName = name
    }
    
    func setBio(bio: String) {
        self.bio = bio
    }
    
    func setAvatar(url: URL) {
        Alamofire.request(url).responseData{ (response) in
            if response.error == nil {
                print(response.result)
                self.avatar = UIImage(data: response.data!)!
            }
        }
    }
    
}

extension GitHubUser: Equatable {
    
    static func ==(lhs: GitHubUser, rhs: GitHubUser) -> Bool {
        return lhs.getPageURL() == rhs.getPageURL()
    }
    
}
