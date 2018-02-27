//
//  AddUserController.swift
//  GitUp
//
//  Created by James Yoo on 2018-02-25.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation
import UIKit

class AddUserController: UIViewController, UISearchBarDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet var userSearchScroll: UIScrollView!
    var searchUserName : String = ""
    
    override func viewDidLoad() {
        userSearchBar.delegate = self
        userSearchScroll.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        userSearchBar.resignFirstResponder()
        self.searchUserName = userSearchBar.text!
        getUserSearchResults()
    }
    
    func getUserSearchResults() {
        let searchRequest = SearchUserRequest()
        searchRequest.getUserSearchData(fullName: searchUserName) { (result) -> () in
            print("Hello")
        }
    }
    
    

    
    

}
    
