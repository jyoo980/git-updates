//
//  GitHubUser.swift
//  GitUp
//
//  Created by James Yoo on 2018-02-26.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation

class GitHubUser {
    
    private var fullName: String = ""
    private var pageURL : URL
    private var imageURL : URL
    
    init(name: String, page: String, image: String) {
        fullName = name
        pageURL = URL(string: page)!
        imageURL = URL(string: image)!
    }
    
    func getFullName() -> String {
        return fullName
    }
    
    func getPageURL() -> URL {
        return pageURL
    }
    
    func getImageURL() -> URL {
        return imageURL
    }
    
}
