//
//  UsersViewController.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 18/05/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	let userRetriever: UserRetriever = UserRetriever()
	
	var users: [User] = []
	var filteredUsers: [User] = []
	
    override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.hidesBackButton = true
		
		self.filteredUsers.append(contentsOf: users)
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.searchBar.delegate = self
		
		self.tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "userCell")
		
		getAllUsers()
		
		self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	@IBAction func disconnectBtn(_ sender: UIButton) {
		StorageManager.clearStorage()
		SocketIOManager.sharedInstance.disconnect()
		navigationController?.popToRootViewController(animated: true)
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if (searchText.isEmpty) {
			self.filteredUsers = []
			self.filteredUsers.append(contentsOf: self.users)
		} else {
			self.filteredUsers = self.users.filter({ (user: User) in
				return (user.firstname.contains(searchText))
			})
		}
		self.tableView.reloadData()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.filteredUsers.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: UserCell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
		
		cell.labelUser.text = self.filteredUsers[indexPath.row].firstname
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let user: User = self.filteredUsers[indexPath.row]
		let userController = ChatViewController(nibName: "ChatViewController", bundle: nil, user: user)
		
		self.navigationController?.pushViewController(userController, animated: true)
	}
	
	func getAllUsers() {
		
		userRetriever.getAllUsers { (users) in
			self.users = []
			self.users.append(contentsOf: users)
			self.filteredUsers = []
			self.filteredUsers.append(contentsOf: self.users)
			
			// Reload data for display thread
			DispatchQueue.main.async(execute: {
				self.tableView.reloadData()
			})
		}
	}
}
