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
            LoginRetriever().login(username: username!, password: password!, callback: { (isConnected) in
                
                if(isConnected) {
                    let usersController = UsersViewController()
                    save.navigationController?.pushViewController(usersController, animated: true)
                }
                else {
                    save.errorLabel.text = "Connection error"
                }
            })
        }
        else {
            self.errorLabel.text = "Please complete all fields"
        }
    }
}
