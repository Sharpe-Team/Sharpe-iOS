//
//  LoginViewController.swift
//  SharpeApp
//
//  Created by etudiant on 28/06/2017.
//  Copyright © 2017 Thomas Fouan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var loginTextView: UITextField!
    @IBOutlet var passwordTextView: UITextField!
    @IBOutlet var connectionBtn: UIButton!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		errorLabel.lineBreakMode = .byWordWrapping
		errorLabel.numberOfLines = 0;
		
		// Check if there is already a token in the local storage.
		// If yes, check its validity and redirect to UsersViewController of it is
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleConnection(_ sender: Any) {
        let username = self.loginTextView.text
        let password = self.passwordTextView.text
        
        let save = self // Useless ? Anonym function like Java ?
        
        if(username != "" && password != "") {
			self.errorLabel.text = ""
			SwiftSpinner.show("Authentification en cours...")
			
            LoginRetriever().login(username: username!, password: password!, callback: { (isConnected, message) in
				
				if(isConnected) {
					SwiftSpinner.hide()
                    let usersController = UsersViewController()
                    save.navigationController?.pushViewController(usersController, animated: true)
                }
				else {
					SwiftSpinner.hide()
                    save.errorLabel.text = message
                }
            })
        }
        else {
            self.errorLabel.text = "Veuillez renseigner tous les champs"
        }
    }
}
