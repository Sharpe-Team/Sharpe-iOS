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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleConnection(_ sender: Any) {
        let username = self.loginTextView.text
        let password = self.passwordTextView.text
        
        if(username != "" && password != "") {
			self.errorLabel.text = ""
			SwiftSpinner.show("Authentification en cours")
			
            LoginRetriever().login(username: username!, password: password!, callback: { (isConnected, token, message) in
				SwiftSpinner.hide()
				
				if(isConnected) {
					StorageManager.storeToken(token: token!)
					SocketIOManager.sharedInstance.login(token: token!)
					
                    let usersController = UsersViewController()
                    self.navigationController?.pushViewController(usersController, animated: true)
                }
				else {
                    self.errorLabel.text = message
                }
            })
        }
        else {
            self.errorLabel.text = "Veuillez renseigner tous les champs"
        }
    }
}
