//
//  Repository.swift
//  GitUp
//
//  Created by James Yoo on 2018-03-04.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation

class Repository {
    
    private var owner: String?
    private var name: String?
    private var commits: [Commit]?
    private var stars: Int?
    let NO_COMMITS = "No commits"
    
    init(owner: String, name: String, stars: Int) {
        self.owner = owner
        self.name = name
        self.stars = stars
        commits = []
    }
   
    func getOwner() -> String {
        return owner!
    }
    
    func getRepoName() -> String {
        return name!
    }

    func getLatestCommit() -> String {
        return (commits!.count > 0) ? commits![0].getMessage() : NO_COMMITS
    }
    
    func getCommits() -> [Commit] {
        return commits!
    }
    
    func getStars() -> Int {
        return stars!
    }
    
    func addCommit(commit: Commit) {
        if !commits!.contains(commit) {
            commits?.append(commit)
        }
    }
    
}
