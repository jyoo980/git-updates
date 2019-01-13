//
//  Commit.swift
//  GitUp
//
//  Created by James Yoo on 2018-03-04.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation

class Commit {
    
    private var sha: String
    private var author: String
    private var message: String
    
    init(sha: String, author: String, message: String) {
        self.sha = sha
        self.author = author
        self.message = message
    }
    
    public func getSha() -> String {
        return sha
    }
    
    public func getAuthor() -> String {
        return author
    }
    
    public func getMessage() -> String {
        return message
    }
    
}

extension Commit: Equatable {
    static func ==(lhs: Commit, rhs: Commit) -> Bool {
        return lhs.getSha() == rhs.getSha()
    }    
}
