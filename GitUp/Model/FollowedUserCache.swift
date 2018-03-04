//
//  FollowedUserCache.swift
//  GitUp
//
//  Created by James Yoo on 2018-03-03.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation

class FollowedUserCache {
    
    static let shared = FollowedUserCache()
    var cache : [String:GitHubUser]
    
    private init() {
        cache = [String:GitHubUser]()
    }
    
    func invalidate() {
        cache.removeAll()
    }
    
    func isEmpty() -> Bool {
        return cache.isEmpty
    }
    
    func set(key: String, user: GitHubUser) {
        if cache[key] == nil {
            cache[key] = user
        }
    }
    
    func fetch(key: String) -> GitHubUser {
        return cache[key]!
    }
    
}
