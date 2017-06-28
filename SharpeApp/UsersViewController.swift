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
		// Do any additional setup after loading the view.

		for i in 0 ..< 5 {
			self.users.append(User(firstname: "Prénom " + String(i), lastname: "Nom " + String(i), email: "toto" + String(i) + "@lala.fr"))
		}
		
		self.filteredUsers.append(contentsOf: users)
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.searchBar.delegate = self
		
		self.tableView.register(UserCell.classForCoder(), forCellReuseIdentifier: "userCell")
		
		getAllUsers()
		
		self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if (searchText.isEmpty) {
			self.filteredUsers = []
			self.filteredUsers.append(contentsOf: self.users)
		} else {
			self.filteredUsers = self.users.filter({ (user: User) in
				return (user.firstname?.contains(searchText))!
			})
		}
		self.tableView.reloadData()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.filteredUsers.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: UserCell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
		
		cell.textLabel?.text = self.filteredUsers[indexPath.row].firstname
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
			
			DispatchQueue.main.async(execute: {
				self.tableView.reloadData()
			})
		}
	}
}
