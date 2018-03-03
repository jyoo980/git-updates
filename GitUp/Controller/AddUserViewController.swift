//
//  AddUserViewController.swift
//  GitUp
//
//  Created by James Yoo on 2018-02-28.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Alamofire
import AlamofireImage
import Foundation
import UIKit

class AddUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var searchedUserTable: UITableView!
    
    var userQuery = ""
    var searchResults : [GitHubUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchedUserTable.delegate = self
        searchedUserTable.dataSource = self
        initializeNavBar()
    }
    
    fileprivate func initializeNavBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.title = "Add a user"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchedUserTable.dequeueReusableCell(withIdentifier: "cell") as! UserTableViewCell
        
        let user = searchResults[indexPath.row] as GitHubUser
        setUserNameText(cell, user)
        setUserAvatar(gitHubUser: user, cell: cell)
        return cell
    }
    
    fileprivate func setUserNameText(_ cell: UserTableViewCell, _ user: GitHubUser) {
        cell.userNameText.text = user.getUserName()
    }
    
    fileprivate func setUserAvatar(gitHubUser: GitHubUser, cell: UserTableViewCell) {
        let imageUrl = gitHubUser.getImageURL()
        Alamofire.request(imageUrl).responseData{ (response) in
            if response.error == nil {
                print(response.result)
                cell.userAvatar.image = UIImage(data: response.data!)
            }
        }
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if (searchBar.text != "") {
//            self.searchResults.removeAll()
//            self.userQuery = userSearchBar.text!
//            searchForUser()
//            self.userSearchBar.endEditing(true)
//        }
//    }
    
    fileprivate func asyncLoadResults(_ result: ([GitHubUser])) {
        DispatchQueue.main.async {
            for user in result {
                self.searchResults.append(user)
            }
            self.searchedUserTable.reloadData()
        }
    }
    
    func searchForUser() {
        assert(userQuery != "")
        let searchUserRequest = SearchUserRequest()
        searchUserRequest.getUserSearchData(fullName: self.userQuery) { (result) -> () in
            self.asyncLoadResults(result)
        }
    }
    
}
