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
    
    init(owner: String, name: String) {
        self.owner = owner
        self.name = name
        commits = []
    }
   
    func getOwner() -> String {
        return owner!
    }
    
    func getRepoName() -> String {
        return name!
    }
    
    func getCommits() -> [Commit] {
        return commits!
    }
    
    func addCommit(commit: Commit) {
        if !commits!.contains(commit) {
            commits?.append(commit)
        }
    }
    
}
