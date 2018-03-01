//
//  AddUserViewController.swift
//  GitUp
//
//  Created by James Yoo on 2018-02-28.
//  Copyright © 2018 James Yoo. All rights reserved.
//

import Foundation
import UIKit

class AddUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var searchedUserTable: UITableView!
    @IBOutlet weak var userSearchBar: UISearchBar!
    
    let testArray = ["James", "Yoo", "GitHub", "Cool"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchedUserTable.delegate = self
        searchedUserTable.dataSource = self
        userSearchBar.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchedUserTable.dequeueReusableCell(withIdentifier: "cell") as! UserTableViewCell
        
        cell.userNameText.text = testArray[indexPath.row]
        return cell
    }
    
    
    
}
