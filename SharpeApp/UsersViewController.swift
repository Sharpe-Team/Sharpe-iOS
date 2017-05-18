//
//  UsersViewController.swift
//  SharpeApp
//
//  Created by Thomas Fouan on 18/05/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

	@IBOutlet weak var usersTableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	var users: [User] = []
	var filteredUsers: [User] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		
	}
}
