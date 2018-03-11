//
//  ProfileDetailRequest.swift
//  GitUp
//
//  Created by James Yoo on 2018-03-04.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation

class ProfileDetailRequest {
    
    func updateProfileDetails(user: GitHubUser) {
        let requestUrl = user.getPageURL()
        let session = URLSession.shared
        let dataTask = session.dataTask(with: requestUrl) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    let responseDict = dataToDict(data: data)
                    self.parsePersonals(dict: responseDict, user: user)
                    self.makeRepoInfoRequest(dict: responseDict, user: user)
                }
            }
        }
        dataTask.resume()
    }
    
    fileprivate func setUserBio(_ dict: NSDictionary, _ user: GitHubUser) {
        if let bio = dict.value(forKey: "bio") as? String {
            user.setBio(bio: bio)
        } else {
            user.setBio(bio: "No bio")
        }
    }
    
    fileprivate func parsePersonals(dict: NSDictionary, user: GitHubUser) {
        let realName = dict.value(forKey: "name") as! String
        setUserBio(dict, user)
        user.setActualName(name: realName)
        
    }
    
    fileprivate func makeRepoInfoRequest(dict: NSDictionary, user: GitHubUser) {
        let url = dict.value(forKey: "repos_url") as! String
        let request = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request!) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    let repoArray = dataToArray(data: data)
                    self.parseRepositories(repositories: repoArray!, user: user)
                }
            }
        }
        dataTask.resume()
    }
    
    fileprivate func parseRepositories(repositories: NSArray, user: GitHubUser) {
        for repo in repositories {
            let repoDictionary = repo as! NSDictionary
            extractRepoData(repo: repoDictionary, user: user)
        }
    }
    
    fileprivate func extractRepoData(repo: NSDictionary, user: GitHubUser) {
        let name = repo.value(forKey: "name") as! String
        let commitUrl = repo.value(forKey: "commits_url") as! String
        let starCount = repo.value(forKey: "stargazers_count") as! Int
        let createdRepo = Repository(owner: user.getUserName(), name: name, stars: starCount)
        parseCommits(fullCommitUrl: commitUrl, repo: createdRepo)
        user.addRepository(repo: createdRepo)
    }
    
    fileprivate func parseCommits(fullCommitUrl: String, repo: Repository) {
        let requestString = fullCommitUrl.components(separatedBy: "commits")[0].appending("commits")
        let url = URL(string: requestString)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    let commitsArray = dataToArray(data: data)
                    if commitsArray != nil {
                        self.parseCommitArray(commits: commitsArray!, repo: repo)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    fileprivate func parseCommitArray(commits: NSArray, repo: Repository) {
        for commit in commits {
            let commitDict = commit as! NSDictionary
            parseOneCommit(commit: commitDict, repo: repo)
        }
    }
    
    fileprivate func parseOneCommit(commit: NSDictionary, repo: Repository) {
        let commitSHA = commit.value(forKey: "sha") as! String
        let commitHistoryDict = commit.value(forKey: "commit") as! NSDictionary
        let message = commitHistoryDict.value(forKey: "message") as! String
        let commit = Commit(sha: commitSHA, author: repo.getOwner(), message: message)
        repo.addCommit(commit: commit)
    }

}
